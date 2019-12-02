function [ES,SLres] = ESS(model,level,cutoff,type,dispWaitBar,excluded)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [ES,SLres] = ESS(model,level,cutoff,type,dispWaitBar)
% Searches for essential/synthetic-lethal reactions/genes (SLres) within a
% given level and calculate essentiality score based on the SLres
%
% INPUT:
% model             The metabolic model in either COBRA or RAVEN format
% OPTIONAL INPUT:
% level             The level (maximal number of synthetic lethality 
%                   analysis) for ESS. Default is 2 and maximal is 3.
% cutoff            minimal fraction of wild type objective flux that
%                   defines lethal or nonlethal. Default is 0.05.
% type              'r' or 'g' defines ESS analysis for either reaction or
%                   genes, respectively. Default is 'r'.
% dispWaitBar       logical variable decides whether to show waitbar or
%                   not. Default is true.
% OUTPUTS:
% ES                Essentiality scores for reactions/genes
% SLres             Synthetic lethal reactions or genes
% 
% Cheng Zhang. Last edited: 2017-08-13
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist('level', 'var')
    if isempty(level)
        level = 2;
    end
else
    level = 2;
end
if exist('cutoff', 'var')
    if isempty(cutoff)
        cutoff = 0.05;
    end
else
    cutoff = 0.05;
end
if exist('type', 'var')
    if isempty(type)
        type = 'r';
    elseif ~strcmpi(type,'r')&&~strcmp(type,'g')
        error('Unknown ESS type selected! Only "r" (reaction) or "g" (gene) could be selected!');
    end
else
    type = 'r';
end
if exist('dispWaitBar', 'var')
    if isempty(dispWaitBar)
        dispWaitBar = true;
    end
else
    dispWaitBar = true;
end
if exist('excluded', 'var')
    if isempty(cutoff)
        excluded = {''};
    end
else
    excluded = {''};
end
%% Performing ESS

switch lower(type)
    case 'r'
        %% Performing FastSL
        disp('Performing FastSL...');
        [SLsingle,SLdouble,SLtriple] = FastSL(model,level,cutoff,dispWaitBar);
        SLsingle(ismember(SLsingle,excluded)) = [];
        if ~isempty(SLdouble)
            SLdouble(ismember(SLdouble(:,1),excluded)|ismember(SLdouble(:,1),excluded),:) = [];
        end
        if ~isempty(SLtriple)
            SLtriple(ismember(SLtriple(:,1),excluded)|ismember(SLtriple(:,2),excluded)|ismember(SLtriple(:,3),excluded),:) = [];
        end
        disp('FastSL is done');
        %% Calculating Essentiality Score
        disp('Calculating essentiality scores...');
        y1 = ismember(model.rxns,SLsingle);
        y2 = zeros(size(y1));
        nR = length(model.rxns);
        if ~isempty(SLdouble)
            for i = 1:length(y2)
                y2(i) = sum(ismember(SLdouble(:,1),model.rxns(i))+ismember(SLdouble(:,2),model.rxns(i)));
            end
        end
        y3 = zeros(size(y1));
        if ~isempty(SLtriple)
            for i = 1:length(y3)
                y3(i) = sum(ismember(SLtriple(:,1),model.rxns(i))+ismember(SLtriple(:,2),model.rxns(i))+ismember(SLtriple(:,3),model.rxns(i)));
            end
        end
        ES = y1 +y2/nR+y3*factorial(2)/nR^2;
        disp('Done');
    case 'g'
        %% Performing FastGeneSL
        disp('Performing FastGeneSL...');
        [SLsingle,SLdouble,SLtriple] = FastGeneSL(model,level,cutoff,dispWaitBar);
        SLsingle(ismember(SLsingle,excluded)) = [];
        if ~isempty(SLdouble)
            SLdouble(ismember(SLdouble(:,1),excluded)|ismember(SLdouble(:,1),excluded),:) = [];
        end
        if ~isempty(SLtriple)
            SLtriple(ismember(SLtriple(:,1),excluded)|ismember(SLtriple(:,2),excluded)|ismember(SLtriple(:,3),excluded),:) = [];
        end
        disp('FastGeneSL is done');
        %% Calculating Essentiality Score
        disp('Calculating essentiality scores...');
        y1 = ismember(model.genes,SLsingle);
        y2 = zeros(size(y1));
        nG = length(model.genes);
        if ~isempty(SLdouble)
            for i = 1:length(y2)
                y2(i) = sum(ismember(SLdouble(:,1),model.genes(i))+ismember(SLdouble(:,2),model.genes(i)));
            end
        end
        y3 = zeros(size(y1));
        if ~isempty(SLtriple)
            for i = 1:length(y3)
                y3(i) = sum(ismember(SLtriple(:,1),model.genes(i))+ismember(SLtriple(:,2),model.genes(i))+ismember(SLtriple(:,3),model.genes(i)));
            end
        end
        ES = y1 +y2/nG+y3*factorial(2)/nG^2;
        disp('Done');
end
SLres{1} = SLsingle;
SLres{2} = SLdouble;
SLres{3} = SLtriple;


end

function [SLsingle,SLdouble,SLtriple] = FastSL(model,level,cutoff,dispWaitBar)
% [singleSL,doubleSL,tripleSL] = CZtoolbox_FastSL(EXsimModel,level,cutoff)
if exist('level', 'var')
    if isempty(level)
        level = 2;
    end
else
    level = 2;
end
if exist('cutoff', 'var')
    if isempty(cutoff)
        cutoff = 0.05;
    end
else
    cutoff = 0.05;
end
if exist('dispWaitBar', 'var')
    if isempty(dispWaitBar)
        dispWaitBar = true;
    end
else
    dispWaitBar = true;
end

tol = 1e-8;

solWT = CZtoolbox_solveLP_mosek(model,1);
grWT = solWT.x(logical(model.c));

switch level
    %% Single level
    case 1
        disp('Performing level 1 FastSL...');
        SLsingle = [];
        NZRind1 = find(abs(solWT.x)>tol);
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying essential reactions...');
        end
        for i = 1:length(NZRind1)
            if dispWaitBar
                waitbar(i/length(NZRind1),h,[num2str(round(i*100/length(NZRind1))) '% completed...']);
            end
            iRind1 = NZRind1(i);
            tmodel1 = model;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1);
            if (isempty(sol1.f) || sol1.x(logical(tmodel1.c))<cutoff*grWT || isempty(sol1.f))
                SLsingle=[SLsingle;NZRind1(i)];
            end
        end
        if dispWaitBar
            close(h);
        end
        SLsingle = model.rxns(SLsingle);
        SLdouble = [];
        SLtriple = [];
        disp('Done');
    %% Double level
    case 2
        disp('Performing level 2 FastSL...');
        %% Part 1
        disp('Part 1 of 2...');
        SLsingle = [];
        NZRind1 = find(abs(solWT.x)>tol);
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying essential reactions...');
        end
        for i = 1:length(NZRind1)
            if dispWaitBar
                waitbar(i/length(NZRind1),h,[num2str(round(i*100/length(NZRind1))) '% completed...']);
            end
            iRind1 = NZRind1(i);
            tmodel1 = model;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1);
            if (isempty(sol1.f) || sol1.x(logical(tmodel1.c))<cutoff*grWT || isempty(sol1.f))
                SLsingle=[SLsingle;NZRind1(i)];
            end
        end
        if dispWaitBar
            close(h);
        end
        NZRind1NE = setdiff(NZRind1,SLsingle);
        disp('Part 1 is done');
        
        %% Part 2
        disp('Part 2 of 2...');
        SLdouble = [];
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying level 2 synthetic lethal reactions...');
        end
        for i = 1:length(NZRind1NE)
            if dispWaitBar
                waitbar(i/length(NZRind1NE),h,[num2str(round(i*100/length(NZRind1NE))) '% completed...']);
            end
            iRind1 = NZRind1NE(i);
            tmodel1 = model;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1,1);
            NZRind2 = find(abs(sol1.x)>tol);
            NZRind2 = setdiff(setdiff(NZRind2,NZRind1NE(1:i-1)),SLsingle);
            for j = 1:length(NZRind2)
                iRind2 = NZRind2(j);
                tmodel2 = tmodel1;
                tmodel2.lb(iRind2) = 0;
                tmodel2.ub(iRind2) = 0;
                sol2 = CZtoolbox_solveLP_mosek(tmodel2);
                if (isempty(sol2.f) || sol2.x(logical(tmodel2.c))<cutoff*grWT || isempty(sol2.f))
                    SLdouble = [SLdouble;NZRind1NE(i),NZRind2(j)];
                end
            end
        end
        if dispWaitBar
            close(h);
        end
        SLsingle = model.rxns(SLsingle);
        SLdouble = model.rxns(SLdouble);
        SLtriple = [];
        disp('Part 2 is done');
    %% Triple level
    case 3
        disp('Performing level 3 FastSL...');
        %% Part 1
        disp('Part 1 of 3...');
        SLsingle = [];
        NZRind1 = find(abs(solWT.x)>tol);
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying essential reactions...');
        end
        for i = 1:length(NZRind1)
            if dispWaitBar
                waitbar(i/length(NZRind1),h,[num2str(round(i*100/length(NZRind1))) '% completed...']);
            end
            iRind1 = NZRind1(i);
            tmodel1 = model;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1);
            if (isempty(sol1.x) || sol1.x(logical(tmodel1.c))<cutoff*grWT || isempty(sol1.f))
                SLsingle=[SLsingle;NZRind1(i)];
            end
        end
        NZRind1NE = setdiff(NZRind1,SLsingle);
        if dispWaitBar
            close(h);
        end

        disp('Part 1 is done');
        %% Part 2
        SLdouble = [];
        disp('Part 2 of 3...');
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying level 2 synthetic lethal reactions...');
        end
        for i = 1:length(NZRind1NE)
            if dispWaitBar
                waitbar(i/length(NZRind1NE),h,[num2str(round(i*100/length(NZRind1NE))) '% completed...']);
            end
            iRind1 = NZRind1NE(i);
            tmodel1 = model;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1,1);
            NZRind2 = find(abs(sol1.x)>tol);
            NZRind2 = setdiff(setdiff(NZRind2,NZRind1NE(1:i-1)),SLsingle);
            for j = 1:length(NZRind2)
                iRind2 = NZRind2(j);
                tmodel2 = tmodel1;
                tmodel2.lb(iRind2) = 0;
                tmodel2.ub(iRind2) = 0;
                sol2 = CZtoolbox_solveLP_mosek(tmodel2);
                if (isempty(sol2.x) || sol2.x(logical(tmodel2.c))<cutoff*grWT || isempty(sol2.f))
                    SLdouble = [SLdouble;NZRind1NE(i),NZRind2(j)];
                end
            end
        end
        if dispWaitBar
            close(h);
        end
        disp('Part 2 is done');
        %% Part 3
        disp('Part 3 of 3...');
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying level 3 synthetic lethal reactions...');
        end
        SLtriple = [];
        SLDmat = sparse([SLdouble(:,1);SLdouble(:,2)],[SLdouble(:,2);SLdouble(:,1)],ones(size(SLdouble,1)*2,1),length(model.rxns),length(model.rxns));
        NZRind1NE = setdiff(NZRind1NE,SLsingle);
        for i = 1:length(NZRind1NE)
            if dispWaitBar
                waitbar(i/length(NZRind1NE),h,[num2str(round(i*100/length(NZRind1NE))) '% completed...']);
            end
            iRind1 = NZRind1NE(i);
            tmodel1 = model;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1,1);
            NZRind2 = find(abs(sol1.x)>tol);
            NZRind2 = setdiff(setdiff(setdiff(NZRind2,NZRind1NE(1:i-1)),SLsingle),find(SLDmat(NZRind1NE(i),:)));
            for j = 1:length(NZRind2)
                iRind2 = NZRind2(j);
                tmodel2 = tmodel1;
                tmodel2.lb(iRind2) = 0;
                tmodel2.ub(iRind2) = 0;
                sol2 = CZtoolbox_solveLP_mosek(tmodel2,1);
                NZRind3 = find(abs(sol2.x)>tol);
                NZRind3 = setdiff(setdiff(NZRind3,union(NZRind2(1:j-1),NZRind1NE(1:i-1))),SLsingle);
                NZRind3 = setdiff(setdiff(NZRind3,find(SLDmat(NZRind1NE(i),:))),find(SLDmat(NZRind2(j),:)));
                for k = 1:length(NZRind3)
                    iRind3 = NZRind3(k);
                    tmodel3 = tmodel2;
                    tmodel3.lb(iRind3) = 0;
                    tmodel3.ub(iRind3) = 0;
                    sol3 = CZtoolbox_solveLP_mosek(tmodel3);
                    if (isempty(sol3.x) || sol3.x(logical(tmodel3.c))<cutoff*grWT || isempty(sol3.f))
                        SLtriple = [SLtriple; NZRind1NE(i), NZRind2(j), NZRind3(k)];
                    end
                end
            end
            
        end
        SLsingle = model.rxns(SLsingle);
        SLdouble = model.rxns(SLdouble);
        SLtriple = model.rxns(SLtriple);
        if dispWaitBar
            close(h);
        end
        disp('Part 3 is done');
    otherwise
        disp('ESS beyond level 3 is currently not available!')           
end

%% Validation
disp('Validating obtained essential/synthetic-lethal reactions...');
for i = 1:size(SLsingle,1)
    tmodel = model;
    Rind = ismember(tmodel.rxns,SLsingle(i));
    tmodel.lb(Rind) = 0;
    tmodel.ub(Rind) = 0;
    solVD = CZtoolbox_solveLP_mosek(tmodel);
    if ~isempty(solVD.x)&&(solVD.x(logical(tmodel.c))>=cutoff*grWT && ~isempty(solVD.f))
        disp(['The obtained single lethal rxns(s) ' SLsingle{i} ' (No.' num2str(i) ') is validated to be wrong!']);
    end
end
for i = 1:size(SLdouble,1)
    tmodel = model;
    Rind = ismember(tmodel.rxns,SLdouble(i,:));
    tmodel.lb(Rind) = 0;
    tmodel.ub(Rind) = 0;
    solVD = CZtoolbox_solveLP_mosek(tmodel);
    if ~isempty(solVD.x)&&(solVD.x(logical(tmodel.c))>=cutoff*grWT && ~isempty(solVD.f))
        disp(['The obtained double lethal rxns(s) ' SLdouble{i,1} ' ' SLdouble{i,2} ' (No.' num2str(i) ') is validated to be wrong!']);
    end
end
for i = 1:size(SLtriple,1)
    tmodel = model;
    Rind = ismember(tmodel.rxns,SLtriple(i,:));
    tmodel.lb(Rind) = 0;
    tmodel.ub(Rind) = 0;
    solVD = CZtoolbox_solveLP_mosek(tmodel);
    if ~isempty(solVD.x)&&(solVD.x(logical(tmodel.c))>=cutoff*grWT && ~isempty(solVD.f))
        disp(['The obtained triple lethal rxns(s) ' SLtriple{i,1} ' ' SLtriple{i,2} ' ' SLtriple{i,3} ' (No.' num2str(i) ') is validated to be wrong!']);
    end
end
disp('Done');
    



end

function [SLsingle,SLdouble,SLtriple,SLquadruple] = FastGeneSL(EXsimModel,level,cutoff,dispWaitBar)
% [singleSL,doubleSL,tripleSL] = CZtoolbox_FastGeneSL(EXsimModel,level,cutoff)
if exist('level', 'var')
    if isempty(level)
        level = 2;
    end
else
    level = 2;
end
if exist('cutoff', 'var')
    if isempty(cutoff)
        cutoff = 0.05;
    end
else
    cutoff = 0.05;
end
if exist('dispWaitBar', 'var')
    if isempty(dispWaitBar)
        dispWaitBar = true;
    end
else
    dispWaitBar = true;
end
disp('Transforming model using LTM...')
EXsimModel = CZtoolbox_LTM(EXsimModel,dispWaitBar);
disp('Done')

tol = 1e-8;

solWT = CZtoolbox_solveLP_mosek(EXsimModel,1);
grWT = solWT.x(logical(EXsimModel.c));

switch level
    %% Single level
    case 1
        disp('Performing level 1 FastGeneSL...');
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying essential genes...');
        end
        SLsingle = [];
        NZrxns1 = EXsimModel.rxns(abs(solWT.x)>tol);
        NZGind1 = find(logical(sum(EXsimModel.rxnGeneMat(ismember(EXsimModel.rxns,NZrxns1),:))));
        for i = 1:length(NZGind1)
            if dispWaitBar
                waitbar(i/length(NZGind1),h,[num2str(round(i*100/length(NZGind1))) '% completed...']);
            end
            iRind1 = logical(EXsimModel.rxnGeneMat(:,NZGind1(i)));
            tmodel1 = EXsimModel;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1);
            if (isempty(sol1.x) || sol1.x(logical(tmodel1.c))<cutoff*grWT)
                SLsingle=[SLsingle;NZGind1(i)];
            end
        end
        SLsingle = EXsimModel.genes(SLsingle);
        SLdouble = [];
        SLtriple = [];
        SLquadruple = [];
        if dispWaitBar
            close(h);
        end
        disp('Done');
    %% Double level
    case 2
        disp('Performing level 2 FastGeneSL...');
        %% Part 1
        disp('Part 1 of 2');
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying essential genes...');
        end
        SLsingle = [];
        NZrxns1 = EXsimModel.rxns(abs(solWT.x)>tol);
        NZGind1 = find(logical(sum(EXsimModel.rxnGeneMat(ismember(EXsimModel.rxns,NZrxns1),:))));
        for i = 1:length(NZGind1)
            if dispWaitBar
                waitbar(i/length(NZGind1),h,[num2str(round(i*100/length(NZGind1))) '% completed...']);
            end
            iRind1 = logical(EXsimModel.rxnGeneMat(:,NZGind1(i)));
            tmodel1 = EXsimModel;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1);
            if (isempty(sol1.x) || sol1.x(logical(tmodel1.c))<cutoff*grWT)
                SLsingle=[SLsingle;NZGind1(i)];
            end
        end
        NZGind1NE = setdiff(NZGind1,SLsingle);
        if dispWaitBar
            close(h);
        end
        disp('Part 1 is done');

        
        %% Part 2
        disp('Part 2 of 2');
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying level 2 synthetic lethal genes...');
        end
        SLdouble = [];
        for i = 1:length(NZGind1NE)
            if dispWaitBar
                waitbar(i/length(NZGind1NE),h,[num2str(round(i*100/length(NZGind1NE))) '% completed...']);
            end
            iRind1 = logical(EXsimModel.rxnGeneMat(:,NZGind1NE(i)));
            tmodel1 = EXsimModel;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1,1);
            NZrxns2 = tmodel1.rxns(abs(sol1.x)>tol);
            NZGind2 = find(logical(sum(tmodel1.rxnGeneMat(ismember(tmodel1.rxns,NZrxns2),:))));
            NZGind2 = setdiff(setdiff(NZGind2,NZGind1NE(1:i-1)),SLsingle);
            for j = 1:length(NZGind2)                
                iRind2 = logical(tmodel1.rxnGeneMat(:,NZGind2(j)));
                tmodel2 = tmodel1;
                tmodel2.lb(iRind2) = 0;
                tmodel2.ub(iRind2) = 0;
                sol2 = CZtoolbox_solveLP_mosek(tmodel2);
                if (isempty(sol2.f)||sol2.x(logical(tmodel2.c))<cutoff*grWT)
                    SLdouble = [SLdouble;NZGind1NE(i),NZGind2(j)];
                end
            end
        end
        SLsingle = EXsimModel.genes(SLsingle);
        SLdouble = EXsimModel.genes(SLdouble);
        SLtriple = [];
        SLquadruple = [];
        if dispWaitBar
            close(h);
        end
        disp('Part 2 is done');
    %% Triple level
    case 3
        disp('Performing level 2 FastGeneSL...');
        %% Part 1
        disp('Part 1 of 3');
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying essential genes...');
        end
        SLsingle = [];
        NZrxns1 = EXsimModel.rxns(abs(solWT.x)>tol);
        NZGind1 = find(logical(sum(EXsimModel.rxnGeneMat(ismember(EXsimModel.rxns,NZrxns1),:))));
        for i = 1:length(NZGind1)
            if dispWaitBar
                waitbar(i/length(NZGind1),h,[num2str(round(i*100/length(NZGind1))) '% completed...']);
            end
            iRind1 = logical(EXsimModel.rxnGeneMat(:,NZGind1(i)));
            tmodel1 = EXsimModel;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1);
            try
                if isempty(sol1.f) || sol1.x(logical(tmodel1.c))<cutoff*grWT
                    SLsingle=[SLsingle;NZGind1(i)];
                end
            catch
                sol1.x(logical(tmodel1.c))<cutoff*grWT
                class(sol1.x(logical(tmodel1.c))<cutoff*grWT)
                isempty(sol1.f)
                class( isempty(sol1.f))
                error('!')
            end
        end
        if dispWaitBar
            close(h);
        end
        disp('Part 1 is done');

        
        %% Part 2
        disp('Part 2 of 3');
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying level 2 synthetic lethal genes...');
        end
        NZGind1NE = setdiff(NZGind1,SLsingle);
        SLdouble = [];
        for i = 1:length(NZGind1NE)
            if dispWaitBar
                waitbar(i/length(NZGind1NE),h,[num2str(round(i*100/length(NZGind1NE))) '% completed...']);
            end
            iRind1 = logical(EXsimModel.rxnGeneMat(:,NZGind1NE(i)));
            tmodel1 = EXsimModel;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1,1);
            NZrxns2 = tmodel1.rxns(abs(sol1.x)>tol);
            NZGind2 = find(logical(sum(tmodel1.rxnGeneMat(ismember(tmodel1.rxns,NZrxns2),:))));
            NZGind2 = setdiff(setdiff(NZGind2,NZGind1NE(1:i-1)),SLsingle);
            for j = 1:length(NZGind2)
                iRind2 = logical(tmodel1.rxnGeneMat(:,NZGind2(j)));
                tmodel2 = tmodel1;
                tmodel2.lb(iRind2) = 0;
                tmodel2.ub(iRind2) = 0;
                sol2 = CZtoolbox_solveLP_mosek(tmodel2);
                if (isempty(sol2.x)||sol2.x(logical(tmodel2.c))<cutoff*grWT)
                    SLdouble = [SLdouble;NZGind1NE(i),NZGind2(j)];
                end
            end
        end
        if dispWaitBar
            close(h);
        end
        disp('Part 2 is done');
        %% Part 3
        disp('Part 3 of 3');
        if dispWaitBar
            h = waitbar(0,'0.00','Name','Identifying level 3 synthetic lethal genes...');
        end
        SLtriple = [];
        SLDmat = sparse([SLdouble(:,1);SLdouble(:,2)],[SLdouble(:,2);SLdouble(:,1)],ones(size(SLdouble,1)*2,1),length(EXsimModel.genes),length(EXsimModel.genes));
        NZGind1NE = setdiff(NZGind1NE,SLsingle);
        for i = 1:length(NZGind1NE)
            if dispWaitBar
                waitbar(i/length(NZGind1NE),h,[num2str(round(i*100/length(NZGind1NE))) '% completed...']);
            end
            iRind1 = logical(EXsimModel.rxnGeneMat(:,NZGind1NE(i)));
            tmodel1 = EXsimModel;
            tmodel1.lb(iRind1) = 0;
            tmodel1.ub(iRind1) = 0;
            sol1 = CZtoolbox_solveLP_mosek(tmodel1,1);
            NZrxns2 = tmodel1.rxns(abs(sol1.x)>tol);
            NZGind2 = find(logical(sum(tmodel1.rxnGeneMat(ismember(tmodel1.rxns,NZrxns2),:))));
            NZGind2 = setdiff(setdiff(setdiff(NZGind2,NZGind1NE(1:i-1)),SLsingle),find(SLDmat(NZGind1NE(i),:)));
            for j = 1:length(NZGind2)
                iRind2 = logical(tmodel1.rxnGeneMat(:,NZGind2(j)));
                tmodel2 = tmodel1;
                tmodel2.lb(iRind2) = 0;
                tmodel2.ub(iRind2) = 0;
                sol2 = CZtoolbox_solveLP_mosek(tmodel2,1);
                NZrxns3 = tmodel2.rxns(abs(sol2.x)>tol);
                NZGind3 = find(logical(sum(tmodel2.rxnGeneMat(ismember(tmodel2.rxns,NZrxns3),:))));
                NZGind3 = setdiff(setdiff(NZGind3,union(NZGind2(1:j-1),NZGind1NE(1:i-1))),SLsingle);
                NZGind3 = setdiff(setdiff(NZGind3,find(SLDmat(NZGind1NE(i),:))),find(SLDmat(NZGind2(j),:)));
                for k = 1:length(NZGind3)
                    iRind3 = logical(tmodel2.rxnGeneMat(:,NZGind3(k)));
                    tmodel3 = tmodel2;
                    tmodel3.lb(iRind3) = 0;
                    tmodel3.ub(iRind3) = 0;
                    sol3 = CZtoolbox_solveLP_mosek(tmodel3);
                    if (isempty(sol3.f) || sol3.x(logical(tmodel3.c))<cutoff*grWT)
                        SLtriple = [SLtriple; NZGind1NE(i), NZGind2(j), NZGind3(k)];
                    end
                end
            end
            
        end
        SLsingle = EXsimModel.genes(SLsingle);
        SLdouble = EXsimModel.genes(SLdouble);
        SLtriple = EXsimModel.genes(SLtriple);
        SLquadruple = [];
        if dispWaitBar
            close(h);
        end
        disp('Part 3 is done');
    otherwise
        disp('ESS level beyond level 3 is currently not availabl!');   
end

%% Validation
disp('Validating obtained essential/synthetic-lethal reactions...');
for i = 1:size(SLsingle,1)
    tmodel = EXsimModel;
    Rind = logical(tmodel.rxnGeneMat(:,ismember(tmodel.genes,SLsingle(i))));
    tmodel.lb(Rind) = 0;
    tmodel.ub(Rind) = 0;
    solVD = CZtoolbox_solveLP_mosek(tmodel);
    if ~isempty(solVD.x)&& solVD.x(logical(tmodel.c))>=cutoff*grWT && ~isempty(solVD.f)
        diplay(['The obtained single lethal gene(s) ' SLsingle{i} ' (No.' num2str(i) ') is validated to be wrong!']);
    end
end
for i = 1:size(SLdouble,1)
    tmodel = EXsimModel;
    Rind = logical(sum(tmodel.rxnGeneMat(:,ismember(tmodel.genes,SLdouble(i,:))),2));
    tmodel.lb(Rind) = 0;
    tmodel.ub(Rind) = 0;
    solVD = CZtoolbox_solveLP_mosek(tmodel);
    if ~isempty(solVD.x)&& solVD.x(logical(tmodel.c))>=cutoff*grWT && ~isempty(solVD.f)
        diplay(['The obtained double lethal gene(s) ' SLdouble{i,1} ' ' SLdouble{i,2} ' (No.' num2str(i) ') is validated to be wrong!']);
    end
end
for i = 1:size(SLtriple,1)
    tmodel = EXsimModel;
    Rind = logical(sum(tmodel.rxnGeneMat(:,ismember(tmodel.genes,SLtriple(i,:))),2));
    tmodel.lb(Rind) = 0;
    tmodel.ub(Rind) = 0;
    solVD = CZtoolbox_solveLP_mosek(tmodel);
    if ~isempty(solVD.x)&& solVD.x(logical(tmodel.c))>=cutoff*grWT && ~isempty(solVD.f)
        disp(['The obtained triple lethal gene(s) ' SLtriple{i,1} ' ' SLtriple{i,2} ' ' SLtriple{i,3} ' (No.' num2str(i) ') is validated to be wrong!']);
    end
end
for i = 1:size(SLquadruple,1)
    tmodel = EXsimModel;
    Rind = logical(sum(tmodel.rxnGeneMat(:,ismember(tmodel.genes,SLquadruple(i,:))),2));
    tmodel.lb(Rind) = 0;
    tmodel.ub(Rind) = 0;
    solVD = CZtoolbox_solveLP_mosek(tmodel);
    if ~isempty(solVD.x)&& solVD.x(logical(tmodel.c))>=cutoff*grWT && ~isempty(solVD.f)
        disp(['The obtained triple lethal gene(s) ' SLquadruple{i,1} ' ' SLquadruple{i,2} ' ' SLquadruple{i,3} ' ' SLquadruple{i,4} ' (No.' num2str(i) ') is validated to be wrong!']);
    end
end

disp('Done');

end

function [solution, hsSolOut] = CZtoolbox_solveLP_mosek(model,minFlux,params,hsSol)
% This is a wrapper for the solveLP function from RAVEN toolbox
% solveLP
%   Solves a linear programming problem
%
%   model         a model structure
%   minFlux       determines if a second optimization should be performed
%                 in order to get rid of loops in the flux distribution
%                 0: no such optimization is performed
%                 1: the sum of abs(fluxes) is minimized. This is the
%                 fastest way of getting rid of loops
%                 2: the square of fluxes is minimized. This tends to
%                 distribute fluxes across iso-enzymes, which results in a
%                 larger number of reactions being used
%                 3: the number of fluxes is minimized. This can result
%                 in the flux distributions that are the easiest to
%                 interpret. Note that this optimization can be very slow
%                 (opt, default 0)
%   params        parameter structure as used by getMILPParams (opt)
%   hsSol         hot-start solution for the LP solver. This can
%                 significantly speed up the process if many similar
%                 optimization problems are solved iteratively. Only used if
%                 minFlux is 0 or 1 (opt)
%
%   solution
%         f       objective value
%         x       primal (flux distribution)
%         stat    exit flag
%                 1: the optimization terminated successfully
%                 0: the solution is feasible, but not necessarily optimal
%                -1: no feasible solution found
%                -2: solution found, but flux minimization failed
%         msg     string describing the status of the optimization
%   hsSolOut      solution to be used as hot-start solution (see the input
%                 parameters). Only used if minFlux is 0 or 1
%
%   Usage: [solution, hsSolOut] = solveLP_mosek(model,minFlux,params,hsSol)
%
%   Eduard Kerkhoven, 2017-11-09
%
% Cheng Zhang, last edited 2018-06-04


if nargin<2
    minFlux=0;
end
if nargin<3
    params.relGap=0.4;
end
if nargin<4
    hsSol=[];
end

%Default return values
hsSolOut=[];
solution.x=[];
solution.f=[];
solution.stat=-1;

%Ignore the hot-start if the previous solution wasn't feasible
if isfield(hsSol,'prosta')
   if strfind(hsSol.prosta,'INFEASIBLE')
        hsSol=[];
   end
end

% Setup the problem to feed to MOSEK.
prob=[];
prob.c=model.c*-1;
prob.a=model.S;
prob.blc=model.b(:,1);
%If model.b has two column, then they are for lower/upper bound on the RHS
prob.buc=model.b(:,min(size(model.b,2),2));
prob.blx=model.lb;
prob.bux=model.ub;

%If hot-start should be used
if ~isempty(hsSol)
   prob.sol.bas=hsSol;
   params.MSK_IPAR_SIM_HOTSTART=1;
end

%Use MSK_OPTIMIZER_FREE_SIMPLEX. This should not be necessary, but I've
%noticed that the interior point solver is not as good at finding feasible
%solutions.
params.MSK_IPAR_OPTIMIZER='MSK_OPTIMIZER_FREE_SIMPLEX';
res = optimizeProb(prob,params);

%Check if the problem was feasible and that the solution was optimal
[isFeasible, isOptimal]=checkSolution(res);

%If the problem was infeasible using hot-start it is often possible to
%re-solve it without hot-start and get a feasible solution
if ~isFeasible && ~isempty(hsSol)
    prob.sol=rmfield(prob.sol,'bas');
    res=optimizeProb(prob,params);
    [isFeasible, isOptimal]=checkSolution(res);
end

%Return without solution if the problem was infeasible
if ~isFeasible
    solution.msg='The problem is infeasible';
    return;
end
if ~isOptimal
    solution.msg='The problem is feasible, but not necessarily optimal';
    solution.stat=0;
else
    %All is well
    solution.stat=1;
    solution.msg='Optimal solution found';
end

%Construct the output structure
if isfield(res.sol.bas,'xx')
    solution.x=res.sol.bas.xx;
    if minFlux<=1
        hsSolOut=res.sol.bas;
        if(isfield(res,'vbasis')) % gurobi uses vbasis and cbasis as hotstart
            hsSolOut.vbasis=res.vbasis;
            hsSolOut.cbasis=res.cbasis;
        end
    end
    solution.f=res.sol.bas.pobjval;
else
    %Interior-point. This is not used at the moment
    solution.x=res.sol.itr.xx;
    solution.f=res.sol.itr.pobjval;
end

%If either the square, the number, or the sum of fluxes should be minimized
%then the objective function value should be fixed before another
%optimization. It is not correct to fix the reactions which participate in
%the objective function to their values in solution.x, as there can be
%multiple solutions with the same objective function value. In addition, this
%approach could result in numerical issues when several fluxes are fixed.
%Instead a new "fake metabolite" is added to the problem. This metabolite
%is produced by each reaction with the stoichiometry that reaction has in
%the objective function. The equality constraint of that "fake metabolite"
%is then set to be at least as good as the objective function value.
if minFlux==1
    model.S=[model.S;prob.c'];
    model.mets=[model.mets;'TEMP'];

    %If the constraint on the objective function value is exact there is a
    %larger risk of numerical errors. However for the quadratic fitting
    %intervals are not allowed
    if size(model.b,2)==1
        model.b=[model.b model.b];
    end
    if solution.f<0
        model.b=[model.b;[-inf solution.f*0.999999]];
    else
        model.b=[model.b;[-inf solution.f*1.000001]];
    end

    %The sum of fluxes should be minimized
    %Convert the model to the irreversible format
    revRxns=find(model.rev);
    if ~isempty(revRxns)
        iModel=CZtoolbox_RevToIrrev(model);
    else
        iModel=model;
    end

    %Minimize all fluxes
    iModel.c(:)=-1;
    sol=CZtoolbox_solveLP_mosek(iModel);

    %Map back to reversible fluxes
    if sol.stat>=0
        solution.x=sol.x(1:numel(model.c));
        solution.x(revRxns)=solution.x(revRxns)-sol.x(numel(model.c)+1:end);
    else
        EM='Could not solve the problem of minimizing the sum of fluxes. Uses output from original problem';
        dispEM(EM,false);
        solution.stat=-2;
    end

end
end

function [isFeasible, isOptimal]=checkSolution(res)
%   Checks if a solution from Mosek is feasible and optimal
%
%   res             the output structure from mosekopt
%
%   isFeasible      true if the solution is feasible
%   isoptimal       true if the solution is optimal
%
%   This function also throws an error if the license has expired.
%
%   Usage: [isFeasible, isOptimal]=checkSolution(res)
%
%   Rasmus Agren, 2015-05-06
%

if res.rcode==1001
	EM='The Mosek licence has expired';
    dispEM(EM);
end
if res.rcode==1008
	EM='The Mosek licence file is missing';
    dispEM(EM);
end
if res.rcode==1010
	EM='The Mosek licence used only supports small problems (up to 300 variables). Have you requested the correct licence?';
    dispEM(EM);
end
if res.rcode==1016
	EM='Mosek licence problem. Are you running several instances on the same licence? Error code "MSK_RES_ERR_LICENSE_MAX"';
    dispEM(EM);
end
if res.rcode==1017
	EM='Mosek licence problem. Error code "MSK_RES_ERR_LICENSE_MOSEKLM_DAEMON"';
    dispEM(EM);
end
isFeasible=false;
isOptimal=false;
if isfield(res,'sol')
    if isfield(res.sol,'bas')
        %There are several types of infeasibilities, but I consider them
        %all to be the same
        if isempty(strfind(res.sol.bas.prosta,'INFEASIBLE'))
            isFeasible=true;
        end
        %There are several types of optimality, but I consider them all to
        %be the same
        if any(strfind(res.sol.bas.solsta,'OPTIMAL'))
            isOptimal=true;
        end
    else
        if isfield(res.sol,'int')
            %There are several types of infeasibilities, but I consider them
            %all to be the same
            if isempty(strfind(res.sol.int.prosta,'INFEASIBLE'))
                isFeasible=true;
            end
            %There are several types of optimality, but I consider them all to
            %be the same
            if any(strfind(res.sol.int.solsta,'OPTIMAL'))
                isOptimal=true;
            end
        else
            %This is when the interior point solver is used. That is currently
            %not the case
            return;
        end
    end
end
end

function [EXsimModel,refRxns] = CZtoolbox_LTM(model,dispWaitBar)
% [EXsimModel,refRxns] = CZtoolbox_LTM(model,dispWaitBar)

model = CZtoolbox_refineGeneNames(model);
model = CZtoolbox_getCoreInfoFromModel(model);
Premodel = model;
if dispWaitBar
    h = waitbar(0,'0.00','Name','Transforming model...');
end
refRxns = cell(size(Premodel.rxns));
for i = 1:length(Premodel.rxns)
    if dispWaitBar
        waitbar(i/length(Premodel.rxns),h,[num2str(round(i*100/length(Premodel.rxns))) '% completed...']);
    end
    [NewGeneSets, ~] = CZtoolbox_getAllPath(Premodel,Premodel.rxns{i});
    if ~isempty(NewGeneSets{1})
        [model,refRxns{i}] = CZtoolbox_extendReactions(model,Premodel.rxns{i},NewGeneSets);
    else
        refRxns{i} = Premodel.rxns{i};
    end

end
EXsimModel = CZtoolbox_returnGeneNames(model);
if dispWaitBar
    close(h);
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [FinalGenesets, FinalReactions] = CZtoolbox_getAllPath(model,reaction)
% Generates clean gene sets with only simple relations (enzyme alone or
% complexes, no isoenzymes). Used by getECnumbers for distinguishing
% complex GPR relationships.
%
% INPUT:
% model             The GEM structure (1x1 struct)
% reaction          The reaction ID   (string)
%
% OUTPUTS:
% FinalGenesets     All gene sets with only "ANDs" (cell array)
% FinalReactions    New reaction IDs (cell array)
% 
% Cheng Zhang. Last edited: 2017-07-28
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [FinalGenesets, FinalReactions] = CZtoolbox_getAllPath(model,reaction)
i = ismember(model.rxns,reaction);        %get index of the selected reaction

FinalGenesets = cell(1,1);
FinalReactions = cell(1,1);

x = 0;      %total number of NewGenesets
NewGenesets = cell(1,1);
NewReactions = cell(1,1);
STR = model.grRules{i};
p = 0;
q = 0;
while p < x+1      %if bracket exist in geneset, means there still exist multi-gene controlled reaction, continue iteration
    STR = strtrim(STR);
    GRbracketL = strfind(STR,'(');     %find all indexes of left bracket
    GRbracketR = strfind(STR,')');     %find all indexes of right bracket
    A = zeros(length(GRbracketL),1);    %ready for saving corresponding dual index of left brackets
    B = zeros(length(GRbracketR),1);    %ready for saving corresponding dual index of right brackets    
         %save the geneset as string STR
    tempSTR = STR;
    for k = 1:length(A)     %identification of all dual brackets
        B(k,1) = min(GRbracketR);   %iteratively get the index of corresponding dual right brackets
        A(k,1) = max(strfind(tempSTR(1:min(GRbracketR)),'('));  %iteratively get the index of corresponding dual left brackets
        GRbracketR = setdiff(GRbracketR,min(GRbracketR));
        tempSTR = [tempSTR(1:A(k,1)-1) '[' tempSTR(A(k,1)+1:length(tempSTR))];
    end
    if  min(A) == 1 & B(A(:,1)==min(A)) == length(STR)     %if there are overall brackets
        STR = STR(min(A)+1:B(A(:,1)==min(A))-1);     %remove the overall bracket
    end
    STR = strtrim(STR);
    GRbracketLtemp = strfind(STR,'(');    %remove the index of overal left bracket
    GRbracketRtemp = strfind(STR,')');    %remove the index of overal right bracket
    A = zeros(length(GRbracketLtemp),1);    %ready for saving corresponding dual index of left brackets
    B = zeros(length(GRbracketRtemp),1);    %ready for saving corresponding dual index of right brackets
    TempGenesets = cell(1,1);
    if ~isempty(A)      %if there are inner brackets 
            
        tempSTR = STR;
        for k = 1:length(A)     %identification of all dual brackets
            B(k,1) = min(GRbracketRtemp);   %iteratively get the index of corresponding dual right brackets
            A(k,1) = max(strfind(tempSTR(1:min(GRbracketRtemp)),'('));  %iteratively get the index of corresponding dual left brackets
            GRbracketRtemp = setdiff(GRbracketRtemp,min(GRbracketRtemp));
            tempSTR = [tempSTR(1:A(k,1)-1) '[' tempSTR(A(k,1)+1:length(tempSTR))];
        end
        subSTR = STR;        
        j = 0;       
        while ~isempty(strfind(subSTR,'('))                
                j = j+1;
                TempGenesets{j,1} = subSTR(min(A):B(A(:,1)==min(A))); %add new Geneset to Geneset
               
                if min(A) <= 1
                    if B(A(:,1)==min(A)) < length(subSTR)
                        subSTR = subSTR(B(A(:,1)==min(A))+1:length(subSTR));
                    end
                elseif B(A(:,1)==min(A)) >= length(subSTR)
                    if min(A) > 1
                        subSTR = subSTR(1:min(A)-1);
                    end
                else
                    subSTR = [subSTR(1:min(A)-1) subSTR(B(A(:,1)==min(A))+1:length(subSTR))];
                end
                
                GRbracketLtemp2 = strfind(subSTR,'(');    %remove the index of overal left bracket
                GRbracketRtemp2 = strfind(subSTR,')');    %remove the index of overal right bracket
                A = zeros(length(GRbracketLtemp2),1);    
                B = zeros(length(GRbracketRtemp2),1);
                tempSTR2 = subSTR;
                for k = 1:length(A)     %identification of all dual brackets in subSTR
                    B(k,1) = min(GRbracketRtemp2);   %iteratively get the index of corresponding dual right brackets
                    A(k,1) = max(strfind(tempSTR2(1:min(GRbracketRtemp2)),'('));  %iteratively get the index of corresponding dual left brackets
                    GRbracketRtemp2 = setdiff(GRbracketRtemp2,min(GRbracketRtemp2));
                    tempSTR2 = [tempSTR2(1:A(k,1)-1) '[' tempSTR2(A(k,1)+1:length(tempSTR2))];
                end
        end             
        for m = 1:length(model.genes)
            if ~isempty(strfind(subSTR,model.genes{m}))               
                TempGenesets{length(TempGenesets)+1,1} = model.genes{m};
            end    
        end 
        if ~isempty(strfind(subSTR,' or '))|| ~isempty(strfind(subSTR,' OR '))
            for k = 1:length(TempGenesets)
                x = x+1;
                NewGenesets{x,1} = TempGenesets{k,1};
                NewReactions{x,1} = {['TempReactions' num2str(x)]};
            end
        elseif ~isempty(strfind(subSTR,' and '))|| ~isempty(strfind(subSTR,' AND '))
            n = 0;
            jumpout = 0;
            genesetSTR = STR;
            while n < j && jumpout == 0
                Left = strfind(genesetSTR,'(');
                Right = strfind(genesetSTR,')');
                A3 = zeros(length(Left),1);    %ready for saving corresponding dual index of left brackets
                B3 = zeros(length(Right),1);
                tempgenesetSTR = genesetSTR;
                for k = 1:length(A3)     %identification of all dual brackets
                    B3(k,1) = min(Right);   %iteratively get the index of corresponding dual right brackets
                    A3(k,1) = max(strfind(tempgenesetSTR(1:min(Right)),'('));  %iteratively get the index of corresponding dual left brackets
                    Right = setdiff(Right,min(Right));
                    tempgenesetSTR = [tempgenesetSTR(1:A3(k,1)-1) '[' tempgenesetSTR(A3(k,1)+1:length(tempgenesetSTR))];
                end        
                LeftBrackets = A3;
                RightBrackets = B3;                
                n = n+1;
                STR2 = TempGenesets{n};
                STR2 = strtrim(STR2);
                GRbracketL2 = strfind(STR2,'(');     %find all indexes of left bracket
                GRbracketR2 = strfind(STR2,')');     %find all indexes of right bracket               
                A2 = zeros(length(GRbracketL2),1);    %ready for saving corresponding dual index of left brackets
                B2 = zeros(length(GRbracketR2),1);    %ready for saving corresponding dual index of right brackets    
                tempSTR2 = STR2;
                for k = 1:length(A2)     %identification of all dual brackets
                    B2(k,1) = min(GRbracketR2);   %iteratively get the index of corresponding dual right brackets
                    A2(k,1) = max(strfind(tempSTR2(1:min(GRbracketR2)),'('));  %iteratively get the index of corresponding dual left brackets
                    GRbracketR2 = setdiff(GRbracketR2,min(GRbracketR2));
                    tempSTR2 = [tempSTR2(1:A2(k,1)-1) '[' tempSTR2(A2(k,1)+1:length(tempSTR2))];
                end
                if  min(A2) == 1 & B2(A2(:,1)==min(A2)) == length(STR2)
                    STR2 = STR2(min(A2)+1:B2(A2(:,1)==min(A2))-1);     %remove the overall bracket
                end  
                GRbracketLtemp2 = strfind(STR2,'(');    %remove the index of overal left bracket
                GRbracketRtemp2 = strfind(STR2,')');    %remove the index of overal right bracket
                A2 = zeros(length(GRbracketLtemp2),1);    %ready for saving corresponding dual index of left brackets
                B2 = zeros(length(GRbracketRtemp2),1);    %ready for saving corresponding dual index of right brackets
                TempGenesets2 = cell(1,1);
                if ~isempty(A2)      %if there are inner brackets             
                    tempSTR2 = STR2;
                    for k = 1:length(A2)     %identification of all dual brackets
                        B2(k,1) = min(GRbracketRtemp2);   %iteratively get the index of corresponding dual right brackets
                        A2(k,1) = max(strfind(tempSTR2(1:min(GRbracketRtemp2)),'('));  %iteratively get the index of corresponding dual left brackets
                        GRbracketRtemp2 = setdiff(GRbracketRtemp2,min(GRbracketRtemp2));
                        tempSTR2 = [tempSTR2(1:A2(k,1)-1) '[' tempSTR2(A2(k,1)+1:length(tempSTR2))];
                    end
                    subSTR2 = STR2;        
                    j2 = 0;      %recorder of gene sets
                    while ~isempty(strfind(subSTR2,'('))                
                        j2 = j2+1;
                        TempGenesets2{j2,1} = subSTR2(min(A2):B2(A2(:,1)==min(A2))); %add new Geneset to Geneset                
                        if min(A2) <= 1
                            if B2(A2(:,1)==min(A2)) < length(subSTR2)
                                subSTR2 = subSTR2(B2(A2(:,1)==min(A2))+1:length(subSTR2));
                            end
                        elseif B2(A2(:,1)==min(A2)) >= length(subSTR2)
                            if min(A2) > 1
                                subSTR2 = subSTR2(1:min(A2)-1);
                            end
                        else
                            subSTR2 = [subSTR2(1:min(A2)-1) subSTR2(B2(A2(:,1)==min(A2))+1:length(subSTR2))];
                        end
                        GRbracketLtemp3 = strfind(subSTR2,'(');    %remove the index of overal left bracket
                        GRbracketRtemp3 = strfind(subSTR2,')');    %remove the index of overal right bracket
                        A2 = zeros(length(GRbracketLtemp3),1);    
                        B2 = zeros(length(GRbracketRtemp3),1);
                        tempSTR2 = subSTR2;
                        for k = 1:length(A2)     %identification of all dual brackets in subSTR
                            B2(k,1) = min(GRbracketRtemp3);   %iteratively get the index of corresponding dual right brackets
                            A2(k,1) = max(strfind(tempSTR2(1:min(GRbracketRtemp3)),'('));  %iteratively get the index of corresponding dual left brackets
                            GRbracketRtemp3 = setdiff(GRbracketRtemp3,min(GRbracketRtemp3));
                            tempSTR2 = [tempSTR2(1:A2(k,1)-1) '[' tempSTR2(A2(k,1)+1:length(tempSTR2))];
                        end
                    end
                    for m = 1:length(model.genes)
                        if ~isempty(strfind(subSTR2,model.genes{m}))                
                            TempGenesets2{length(TempGenesets2)+1,1} = model.genes{m};                
                        end    
                    end
                else
                    subSTR2 = STR2;
                    j2 = 0;
                    for m = 1:length(model.genes)
                        if ~isempty(strfind(subSTR2,model.genes{m}))
                            TempGenesets2{j2+1,1} = model.genes{m};
                            j2 = j2+1;                                            
                        end    
                    end
                end
                if ~isempty(strfind(subSTR2,' or '))|| ~isempty(strfind(subSTR2,' OR '))
                    jumpout = 1;
                    for k = 1:length(TempGenesets2)
                        x = x+1;
                        if min(LeftBrackets) <= 1
                            if RightBrackets(LeftBrackets(:,1)==min(LeftBrackets)) < length(genesetSTR)
                                NewGenesets{x,1} = [TempGenesets2{k,1} genesetSTR(RightBrackets(LeftBrackets(:,1)==min(LeftBrackets))+1:length(genesetSTR))];
                            end
                        elseif RightBrackets(LeftBrackets(:,1)==min(LeftBrackets)) >= length(genesetSTR)
                            if min(LeftBrackets) > 1
                                NewGenesets{x,1} = [genesetSTR(1:min(LeftBrackets)-1) TempGenesets2{k,1}];
                            end
                        else
                            NewGenesets{x,1} = [genesetSTR(1:min(LeftBrackets)-1) TempGenesets2{k,1} genesetSTR(RightBrackets(LeftBrackets(:,1)==min(LeftBrackets))+1:length(genesetSTR))];
                        end
                        NewReactions{x,1} = {['TempReactions' num2str(x)]};                            
                    end
                else
                    if min(LeftBrackets) <= 1
                        if RightBrackets(LeftBrackets(:,1)==min(LeftBrackets)) < length(genesetSTR)
                            genesetSTR = [STR2 genesetSTR(RightBrackets(LeftBrackets(:,1)==min(LeftBrackets))+1:length(genesetSTR))];
                        end
                    elseif RightBrackets(LeftBrackets(:,1)==min(LeftBrackets)) >= length(genesetSTR)
                        if min(LeftBrackets) > 1
                            genesetSTR = [genesetSTR(1:min(LeftBrackets)-1) STR2];
                        end
                    else
                        genesetSTR = [genesetSTR(1:min(LeftBrackets)-1) STR2 genesetSTR(RightBrackets(LeftBrackets(:,1)==min(LeftBrackets))+1:length(genesetSTR))];
                    end    
                end
            end
            if jumpout == 0
                x = x+1;
                NewGenesets{x,1} = genesetSTR;
            end            
        end
        A = zeros(length(GRbracketLtemp),1); 
    elseif isempty(A)
        subSTR = STR;        
        if ~isempty(strfind(subSTR,' or '))|| ~isempty(strfind(subSTR,' OR '))
            n = 0;
            for m = 1:length(model.genes)
                if ~isempty(strfind(subSTR,model.genes{m}))
                    n = n+1;                
                    TempGenesets{n,1} = model.genes{m};                
                end    
            end 
            for k = 1:length(TempGenesets)
                q = q+1;
                FinalGenesets{q,1} = TempGenesets{k,1};
                FinalReactions{q,1} = {[reaction 'No' num2str(q)]};
            end
        elseif ~isempty(strfind(subSTR,' and '))|| ~isempty(strfind(subSTR,' AND '))
            q = q+1;
            FinalGenesets{q,1} = STR;
            FinalReactions{q,1} = {[reaction 'No' num2str(q)]};
        else
            q = q+1;
            FinalGenesets{q,1} = STR;
            FinalReactions{q,1} = {[reaction 'No' num2str(q)]};
        end
    end
    p = p+1;
    if p <= length(NewGenesets)
        STR = NewGenesets{p,1};
    end
end

end

function [model,refRxn] = CZtoolbox_extendReactions(model,reaction,NewGeneSets)
% [model,refRxn] = CZtoolbox_extendReactions(model,reaction,NewGeneSets)
nPath = size(NewGeneSets,1);
prCount = 0;
pmCount = 0;
indR = find(ismember(model.rxns,reaction));
ub = model.ub(indR);
lb = model.lb(indR);
c = model.c(indR);
leftMets = model.mets(model.S(:,indR)<0);
rightMets = model.mets(model.S(:,indR)>0);
leftS = model.S(model.S(:,indR)<0,indR);
rightS = model.S(model.S(:,indR)>0,indR);

if nPath>1
    model = CZtoolbox_addReactionForSimModel(model,['LeftArm_' reaction],[leftS;1],[leftMets;{['LeftPM_' reaction]}],[],lb,ub,c);
    model = CZtoolbox_addReactionForSimModel(model,['RightArm_' reaction],[-1;rightS],[{['RightPM_' reaction]};rightMets],[],lb,ub,[]);
    model = CZtoolbox_removeReactionForSimModel(model,reaction);
    refRxn = ['LeftArm_' reaction];
%     model = CZtoolbox_addReactionForSimModel(model,reaction,[-1;1],{['LeftPM_' reaction],['RightPM_' reaction]},[],lb,ub,[],c);
end

for i = 1:size(NewGeneSets,1)
    newGenes = strsplit(NewGeneSets{i,1},' and ');
    newGenes = strrep(newGenes,' ','');
    nNewGenes = length(newGenes);
    for j = 1:nNewGenes
        prCount = prCount+1;
        if j == 1
            pmCount = pmCount+1;
            if nPath>1 && nNewGenes>1
                model = CZtoolbox_addReactionForSimModel(model,['PR_' reaction '_No' num2str(prCount)],[-1;1],{['LeftPM_' reaction];['PM_' reaction '_No' num2str(pmCount)]},newGenes{j},[],[],[]);
            elseif nPath==1 && nNewGenes>1
                model = CZtoolbox_addReactionForSimModel(model,['PR_' reaction '_No' num2str(prCount)],[leftS;1],[leftMets;{['PM_' reaction '_No' num2str(pmCount)]}],newGenes{j},lb,ub,c);
                model = CZtoolbox_removeReactionForSimModel(model,reaction);
                refRxn = ['PR_' reaction '_No' num2str(prCount)];
            elseif nPath>1 && nNewGenes==1
                model = CZtoolbox_addReactionForSimModel(model,['PR_' reaction '_No' num2str(prCount)],[-1;1],{['LeftPM_' reaction];['RightPM_' reaction]},newGenes{j},[],[],[]);
            else
                refRxn = reaction;
            end
        elseif j == nNewGenes && nPath>1
            model = CZtoolbox_addReactionForSimModel(model,['PR_' reaction '_No' num2str(prCount)],[-1;1],{['PM_' reaction '_No' num2str(pmCount)];['RightPM_' reaction]},newGenes{j},[],[],[]);
        elseif j == nNewGenes && nPath==1
            model = CZtoolbox_addReactionForSimModel(model,['PR_' reaction '_No' num2str(prCount)],[-1;rightS],[{['PM_' reaction '_No' num2str(pmCount)]};rightMets],newGenes{j},[],[],[]);
        else
            pmCount = pmCount+1;
            model = CZtoolbox_addReactionForSimModel(model,['PR_' reaction '_No' num2str(prCount)],[-1;1],{['PM_' reaction '_No' num2str(pmCount-1)];['PM_' reaction '_No' num2str(pmCount)]},newGenes{j},[],[],[]);
        end
    end
end
model.rev = zeros(size(model.lb));
model.rev(model.lb<0) = 1;
end

function simModel = CZtoolbox_addReactionForSimModel(simModel,rxnName,stoich,mets,grRule,lb,ub,c)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
% simModel       simModel obtained by a COBRA or RAVEN model;
% rxnName        name for the new reaction
% stoich         numeric vector showing the stoichiometric coefficient of
%                new mets
% mets           cell array showing the new metablites for the new reaciton
% grRule         grRule for the new reaction, default is ''
% lb             lower bound for the new reaction, default is -1000
% ub             upper bound for the new reaction, default is 1000
% b              b for the new reaction, default is 0 vector with the same
%                length of mets
% c              weight for objective function, default is 0
%
% Output
% simModel       extended logic model in the selected format;
%
% Cheng Zhang, 2017-07-28
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Check input
if ismember(rxnName,simModel.rxns)
    error('Reaction with the same name already exist in the model!');
end

if length(stoich)~= length(mets)
    error('Stoich and mets should have the same length!');
end

if exist('grRule', 'var')
    if isempty(grRule)
        grRule = {''};
    elseif ischar(grRule)
        grRule = {grRule};
    end
else
    grRule = {''};
end
if exist('ub', 'var')
    if isempty(ub)
        ub = 1000;
    end
else
    ub = '';
end

if exist('lb', 'var')
    if isempty(lb)
        lb = -1000;
    end
else
    lb = -1000;
end
if exist('c', 'var')
    if isempty(c)
        c = 0;
    end
else
    c = 0;
end


%% For S matrix

simModel.S = [simModel.S,sparse(size(simModel.S,1),1)];
simModel.rxns = [simModel.rxns;rxnName];

if ~isempty(setdiff(mets,simModel.mets))
    extraMets = setdiff(mets,simModel.mets);
    simModel.S = [simModel.S;sparse(length(extraMets),size(simModel.S,2))];
    simModel.mets = [simModel.mets;extraMets];
    simModel.b = [simModel.b;zeros(length(extraMets),1)];
end

for i = 1:length(mets)
    simModel.S(ismember(simModel.mets,mets{i}),ismember(simModel.rxns,rxnName)) = stoich(i);
end

%% For other parameters
simModel.lb = [simModel.lb;lb];
simModel.ub = [simModel.ub;ub];
simModel.c = [simModel.c;c];
%% For rxnGeneMat

simModel.grRules = [simModel.grRules;grRule];
simModel.rxnGeneMat = [simModel.rxnGeneMat;sparse(1,size(simModel.rxnGeneMat,2))];
grText = strrep(grRule{1},'and','$');
grText = strrep(grText,'And','$');
grText = strrep(grText,'AND','$');
grText = strrep(grText,'OR','$');
grText = strrep(grText,'Or','$');
grText = strrep(grText,'or','$');
grText = strrep(grText,'(','');
grText = strrep(grText,')','');
genes = strsplit(grText,'$');
extraGenes = setdiff(genes,simModel.genes);

if ~isempty(extraGenes)&&~strcmp(extraGenes{1},'')
    
    simModel.rxnGeneMat = [simModel.rxnGeneMat,sparse(size(simModel.rxnGeneMat,1),length(extraGenes))];
    simModel.genes = [simModel.genes;extraGenes];
end

simModel.rxnGeneMat(ismember(simModel.rxns,rxnName),ismember(simModel.genes,genes)) = 1;

end

function simModel = CZtoolbox_getCoreInfoFromModel(model)
% Input
% model          model in COBRA or RAVEN format;
%
% Output
% simModel       extended logic model in the selected format;
%
% Cheng Zhang, 2017-07-28


if isfield(model,'S')
    simModel.S = model.S;
end
if isfield(model,'b')
    simModel.b = model.b;
end
if isfield(model,'c')
    simModel.c = model.c;
end
if isfield(model,'lb')
    simModel.lb = model.lb;
end
if isfield(model,'ub')
    simModel.ub = model.ub;
end
if isfield(model,'rxns')
    simModel.rxns = model.rxns;
end
if isfield(model,'genes')
    simModel.genes = model.genes;
end
if isfield(model,'mets')
    simModel.mets = model.mets;
end
if isfield(model,'rxnGeneMat')
    simModel.rxnGeneMat = model.rxnGeneMat;
end
if isfield(model,'grRules')
    simModel.grRules = model.grRules;
end
if isfield(model,'geneMapping')
    simModel.geneMapping = model.geneMapping;
end

end

function model = CZtoolbox_refineGeneNames(model)
% model = CZtoolbox_refineGeneNames(model)
model.geneMapping = [model.genes,model.genes];
x = log10(length(model.genes));
x = round(x+0.5);
CheckInd = ones(length(model.genes),1);
while sum(CheckInd)>0
    for i = 1:length(model.genes)
        if length(find(~cellfun(@isempty,strfind(model.genes,model.genes{i}))))==1
            ind = find(~cellfun(@isempty,strfind(model.grRules,model.genes{i})));
            model.genes{i} = ['g' repmat('¤',1,x-round(log10(i)+0.5)+1) num2str(i)];

            for j = 1:length(ind)
                model.grRules{ind(j)} = strrep(model.grRules{ind(j)},model.geneMapping{i,1},model.genes{i});
                model.geneMapping{i,2} = model.genes{i};
            end
            CheckInd(i) = 0;
        end

    end
end

end

function simModel = CZtoolbox_removeReactionForSimModel(simModel,rxnName)
% simModel = CZtoolbox_removeReactionForSimModel(simModel,rxnName)
%% Check input
if ~ismember(rxnName,simModel.rxns)
    error('Selected reaction is not in the model!');
end


%% For S matrix
indR = find(ismember(simModel.rxns,rxnName));

simModel.S(:,indR) = [];
simModel.rxns(indR) = [];

if sum(sum(logical(simModel.S),2)==0)>0
    indM = sum(logical(simModel.S),2)==0;
    simModel.b(indM) = [];
    simModel.mets(indM) = [];
    simModel.S(indM,:) = [];
end

%% For other parameters
simModel.lb(indR) = [];
simModel.ub(indR) = [];
simModel.c(indR) = [];
simModel.grRules(indR) = [];


%% For rxnGeneMat
simModel.rxnGeneMat(indR,:) = [];
if sum(sum(logical(simModel.rxnGeneMat),1)==0)>0
    indG = sum(logical(simModel.rxnGeneMat),1)==0;
    simModel.genes(indG) = [];
    simModel.rxnGeneMat(:,indG) = [];
end


end

function model = CZtoolbox_returnGeneNames(model)
% model = CZtoolbox_returnGeneNames(model)

for i = 1:length(model.genes)
    iGene = model.genes{i};
    model.genes{i} = model.geneMapping{ismember(model.geneMapping(:,2),model.genes{i}),1};
    model.grRules = strrep(model.grRules,iGene,model.genes{i});
    

end

end

function irrevModel = CZtoolbox_RevToIrrev(model)


% convertToIrrev
%   Converts a model to irreversible form
%
%   model         a model structure
%   rxns          cell array with the reactions so split (if reversible)
%                 (opt, default model.rxns)
%
%   irrevModel    a model structure where reversible reactions have
%                 been split into one forward and one reverse reaction
%
%   The reverse reactions are saved as 'REV_rxnID'.
%
%   Usage: irrevModel=convertToIrrev(model,rxns)
%
%   Rasmus Agren, 2013-08-01
%   Cheng Zhang modified, 2016-04-22


if nargin<2
    rxns=model.rxns;
end

irrevModel=model;

I=getIndexes(model,rxns,'rxns',true);

revIndexesBool=model.rev~=0 & I;
revIndexes=find(revIndexesBool);
if any(revIndexesBool)
    irrevModel.S=[model.S,model.S(:,revIndexes)*-1];
    irrevModel.rev(revIndexes)=0;
    irrevModel.rev=[irrevModel.rev;zeros(numel(revIndexes),1)];
    
    %Get the limits for all normal and reversible rxns
    ubNormal=irrevModel.ub;
    ubNormal(revIndexes(ubNormal(revIndexes)<0))=0;
    lbNormal=irrevModel.lb;
    lbNormal(revIndexes(lbNormal(revIndexes)<0))=0;
    ubRev=irrevModel.lb(revIndexes)*-1;
    ubRev(ubRev<0)=0;
    lbRev=irrevModel.ub(revIndexes)*-1;
    lbRev(lbRev<0)=0;
    irrevModel.ub=[ubNormal;ubRev];
    irrevModel.lb=[lbNormal;lbRev];

    %The objective coefficents should be zero for the backwards reversible
    %reactions unless they were negative in the original. In that case they
    %should be positive for the backwards reversible and deleted from the
    %original
    irrevC=zeros(numel(revIndexes),1);
    
    if any(irrevModel.c(revIndexes)<0)
        originalC=irrevModel.c(revIndexes);
        irrevC(irrevModel.c(revIndexes)<0)=originalC(originalC<0)*-1;
        irrevModel.c(irrevModel.c<0 & revIndexesBool)=0;
    end
    irrevModel.c=[irrevModel.c;irrevC];

    irrevModel.rxns=[irrevModel.rxns;strcat(irrevModel.rxns(revIndexes),'_REV')];
    if isfield(irrevModel,'rxnsNames')
        irrevModel.rxnNames=[irrevModel.rxnNames;strcat(irrevModel.rxnNames(revIndexes),' (reversible)')];
    end

    if isfield(irrevModel,'grRules')
        irrevModel.grRules=[irrevModel.grRules;irrevModel.grRules(revIndexes,:)];
    end
    if isfield(irrevModel,'rules')
        irrevModel.rules=[irrevModel.rules;irrevModel.rules(revIndexes,:)];
    end
    if isfield(irrevModel,'rxnMiriams')
        irrevModel.rxnMiriams=[irrevModel.rxnMiriams;irrevModel.rxnMiriams(revIndexes,:)];
    end
    if isfield(irrevModel,'rxnGeneMat')
        irrevModel.rxnGeneMat=[irrevModel.rxnGeneMat;irrevModel.rxnGeneMat(revIndexes,:)];
    end
    if isfield(irrevModel,'subSystems')
    	irrevModel.subSystems=[irrevModel.subSystems;irrevModel.subSystems(revIndexes)];
    end
    if isfield(irrevModel,'eccodes')
    	irrevModel.eccodes=[irrevModel.eccodes;irrevModel.eccodes(revIndexes)];
    end
    if isfield(irrevModel,'rxnComps')
    	irrevModel.rxnComps=[irrevModel.rxnComps;irrevModel.rxnComps(revIndexes)];
    end
    if isfield(irrevModel,'rxnFrom')
    	irrevModel.rxnFrom=[irrevModel.rxnFrom;irrevModel.rxnFrom(revIndexes)];
    end
    if isfield(irrevModel,'rxnReferences')
    	irrevModel.rxnReferences=[irrevModel.rxnReferences;irrevModel.rxnReferences(revIndexes)];
    end
    if isfield(irrevModel,'rxnECNumbers')
    	irrevModel.rxnECNumbers=[irrevModel.rxnECNumbers;irrevModel.rxnECNumbers(revIndexes)];
    end
    if isfield(irrevModel,'rxnNotes')
    	irrevModel.rxnNotes=[irrevModel.rxnNotes;irrevModel.rxnNotes(revIndexes)];
    end
    if isfield(irrevModel,'EC')
    	irrevModel.EC=[irrevModel.EC;irrevModel.EC(revIndexes)];
    end
end
end

function dispEM(string,throwErrors,toList,trimWarnings)
% dispEM
%   Helper function to print warning/errors
%
%   string          the warning/error to show. "WARNING: " is appended automatically
%                   if a warning
%   throwErrors     true if the function should throw an error (opt, default true)
%   toList          a cell array of items to list. If supplied, then the
%                   string will be printed followed by each element in
%                   toList. If it is supplied but empty then nothing is
%                   printed (opt, default {})
%   trimWarnings    true if only a maximal of 10 items should be displayed in
%                   a given error/warning (opt, default true)
%
%   Usage: dispEM(string,throwErrors,toList,trimWarnings)
%
%   Rasmus Agren, 2013-08-01
%

if nargin<2
    throwErrors=true;
end
if nargin<3
    toList=[];
else
    if isempty(toList)
        return;
    end
end
if nargin<4
    trimWarnings=true;
end
if numel(toList)>10 && trimWarnings==true
   toList{10}=['...and ' num2str(numel(toList)-9) ' more'];
   toList(11:end)=[];
end
if throwErrors==false
    errorText=['WARNING: ' string '\n'];
else
    errorText=[string '\n'];
end
if ~isempty(toList)
    for i=1:numel(toList)
        errorText=[errorText '\t' toList{i} '\n'];
    end
end
if throwErrors==false
    fprintf([errorText '\n']);
else
    throw(MException('',errorText));
end
end

function indexes=getIndexes(model,objects, type, returnLogical)
% getIndexes
%   Retrieves the indexes for a list of reactions or metabolites
%
%   model           a model structure
%   objects         either a cell array of IDs, a logical vector with the 
%                   same number of elements as metabolites in the model,
%                   of a vector of indexes
%   type            'rxns', 'mets', or 'genes' depending on what to retrieve
%   returnLogical   Sets whether to return a logical array or an array with
%                   the indexes (opt, default false)
%
%   indexes         can be a logical array or a double array depending on
%                   the value of returnLogical
%
% 	Usage: indexes=getIndexes(model,objects, type, returnLogical)
%
%   Rasmus Agren, 2013-08-01
%

if nargin<4
    returnLogical=false;
end

%If the supplied object is a character array, then convert it to a cell
%array
if ischar(objects)
    objects={objects};
end

indexes=[];

if strcmpi(type,'rxns')
    searchIn=model.rxns;
else
    if strcmpi(type,'mets')
        searchIn=model.mets;
    else
        if strcmpi(type,'genes')
            searchIn=model.genes;
        else
            dispEM('Incorrect value of the "type" parameter. Allowed values are "rxns", "mets" or "genes"'); 
        end
    end
end

if iscell(objects)
    for i=1:numel(objects)
        index=find(strcmp(objects(i),searchIn),1);
        if ~isempty(index)
            indexes(i)=index;
        else
            dispEM(['Could not find object ' objects{i} ' in the model']);
        end
    end
else
    %Now it's either a logical (or 0/1) array or an array with indexes.
    %We want it to be an array with indexes.
    if all(objects)
        %This gets weird if it's all 1
        indexes=objects;
    else
        indexes=find(objects);
    end
end

if returnLogical==true
    tempIndexes=false(numel(searchIn),1);
    tempIndexes(indexes)=true;
    indexes=tempIndexes;
end

indexes=indexes(:);
end

function res = optimizeProb(prob,params)
% optimizeProb
%   Optimize an LP or MILP formulated in mosek terms.
%
%   prob	mosek style LP/MILP problem struct to be optimised
%   params	solver specific parameters (optional)
%
%   res		the output structure from the selected solver RAVENSOLVER
%   		(mosek style)
%
%	Cheng Zhang, 2018-06-04

if nargin<2
    params=[];
end

milp=false;
if(isfield(prob,'ints')), disp('MILP detected.'); milp=true; end

if (milp)
    echo=0;
    if isfield(params,'printReport') && params.printReport==true
        echo='3';
    end
    [~,res] = mosekopt(['minimize echo(' echo ')'],prob,getMILPParams(params));
else
    [~,res] = mosekopt('minimize echo(0)',prob);
end



end




















function [ans] = cbr()
    
    similarity_threshold = 0.90;

    opts = detectImportOptions('../datasets/transformed/Train_Treated.csv');
    opts.Delimiter = ';';
    opts.VariableTypes = ["double", "double", "double", "double", ...
                        "double", "double", "double", ...
                        "double", "double", "double", ...
                        "double", "double", "double", ...
                        "double", "double", "double", ...
                        "double", "double"];
    case_library = readtable('../datasets/transformed/Train_Treated.csv', opts);
    
    new_data = case_library;

    nan_row_indexes = find(isnan(case_library.Stage));
    
    if  isempty(nan_row_indexes)
        error('[CBR] No case with NaN value in the "Stage" column found. The dataset is probably already treated...');
    end
   
    fprintf("[CBR] Similarity threshold: %.2f%%", similarity_threshold);
    
    for i = 1 : length(nan_row_indexes)
    
        new_case = case_library(nan_row_indexes(i),:);
        
        fprintf("\n\n[CBR] Analysing similarities with case %d", new_case.ID);

        [retrieved_indexes, similarities, new_case]=retrieve(case_library, new_case, similarity_threshold, nan_row_indexes);
        
        if isempty(retrieved_indexes)
            error("\n[CBR] Coudn't find any case with similarity above the threshold.");
        else
            
            retrieved_cases = case_library(retrieved_indexes, :);
            retrieved_cases.Similarity = similarities';
            
            sim_array = [retrieved_cases.Similarity];
            
            [max_value, max_index] = max(sim_array);

            fprintf("\n[CBR] Found %d similar cases\n[CBR] Most similar case is %d and has a similarity of %.2f%%.", ...
                length(retrieved_indexes), max_index, max_value);


            new_data(new_case.ID, "Stage") = new_data(max_index, "Stage");

        end

    end
    
    writetable(new_data, '../datasets/transformed/Train_Treated.csv', 'Delimiter', ';');

    fprintf('\n\n[CBR] Retrieve phase completed...\n\n');

end
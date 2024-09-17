function [retrieved_indexes, similarities, new_case] = retrieve(case_library, new_case, threshold, nan_row_indexes)
        
    weights = [1 1 2 2 1 2 2 3 3 3 2 2 3 2 3 3 3];
    
    max_values=get_max_values(case_library);
    
    retrieved_indexes = [];
    similarities = [];

    for i=1:size(case_library,1)
        
        if ~ismember(i, nan_row_indexes)

            distances= zeros(1,17);
            
            distances(1,1)=calculate_linear_distance(case_library{i,"N_Days"} /max_values('N_Days'),new_case.N_Days/max_values('N_Days'));
    
            if new_case.Status==case_library{i,"Status"}
                distances(1,2)=0;
            else
                distances(1,2)=1;
            end
    
            if new_case.Drug==case_library{i,'Drug'}
                distances(1,3)=0;
            else
                distances(1,3)=1;
            end
    
            distances(1,4)=calculate_linear_distance(case_library{i,"Age"} /max_values('Age'),new_case.Age/max_values('Age'));
        
            if new_case.Sex==case_library{i,'Sex'}
                distances(1,5)=0;
            else
                distances(1,5)=1;
            end
    
            if new_case.Ascites==case_library{i,'Ascites'}
                distances(1,6)=0;
            else
                distances(1,6)=1;
            end
    
            if new_case.Edema==case_library{i,'Edema'}
                distances(1,7)=0;
            else
                distances(1,7)=1;
            end
    
            distances(1,8)=calculate_linear_distance(case_library{i,"Bilirubin"} /max_values('Bilirubin'),new_case.Bilirubin/max_values('Bilirubin'));
    
            distances(1,9)=calculate_linear_distance(case_library{i,"Cholesterol"} /max_values('Cholesterol'),new_case.Cholesterol/max_values('Cholesterol'));
    
            distances(1,10)=calculate_linear_distance(case_library{i,"Albumin"} /max_values('Albumin'),new_case.Albumin/max_values('Albumin'));
    
            distances(1,11)=calculate_linear_distance(case_library{i,"Copper"} /max_values('Copper'),new_case.Copper/max_values('Copper'));
    
            distances(1,12)=calculate_linear_distance(case_library{i,"Alk_Phos"} /max_values('Alk_Phos'),new_case.Alk_Phos/max_values('Alk_Phos'));
    
            distances(1,13)=calculate_linear_distance(case_library{i,"SGOT"} /max_values('SGOT'),new_case.SGOT/max_values('SGOT'));
    
            distances(1,14)=calculate_linear_distance(case_library{i,"Tryglicerides"} /max_values('Tryglicerides'),new_case.Tryglicerides/max_values('Tryglicerides'));
    
            distances(1,15)=calculate_linear_distance(case_library{i,"Platelets"} /max_values('Platelets'),new_case.Platelets/max_values('Platelets'));
    
            distances(1,16)=calculate_linear_distance(case_library{i,"Prothrombin"} /max_values('Prothrombin'),new_case.Prothrombin/max_values('Prothrombin'));
    
            if isfield(new_case,'Stage')
                if new_case.Stage==case_library{i,'Stage'}
                    distances(1,17)=0;
                else
                    distances(1,17)=1;
                end
            end
    
            DG=(distances*weights')/sum(weights);
            final_similarity = 1-DG;
            
            if final_similarity >= threshold
                retrieved_indexes = [retrieved_indexes i];
                similarities = [similarities final_similarity];
            end
            
            %fprintf('\n\tCase %d out of %d has a similarity of %.2f%%...', i, size(case_library,1), final_similarity*100);
        end
    end

end

function [max_values] = get_max_values(case_library)
    key_set = {'N_Days','Age','Bilirubin','Cholesterol','Albumin','Copper','Alk_Phos','SGOT','Tryglicerides','Platelets','Prothrombin'};

    value_set = cell(1, numel(key_set));

    for i = 1:numel(key_set)
        value_set{i} = max(case_library(:,key_set{i}));
    end
    max_values = containers.Map(key_set, cellfun(@table2array, value_set));
end

function [res] = calculate_linear_distance(val1, val2)

   res = abs(val1-val2);
end

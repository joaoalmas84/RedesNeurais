function best_net_index = findBestNet(train_accuracies, test_accuracies)
    if length(train_accuracies) ~= length(test_accuracies)
        error('Input arrays must have the same length.');
    end
    
    weighted_val=train_accuracies+1.5*test_accuracies;

    [~, best_net_index] = max(weighted_val);
end
function [normalized_values] = normalize(values)
    normalized_values = (values-min(values)) / (max(values)-min(values));
end
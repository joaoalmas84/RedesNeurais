function [newTarget] = getTarget(target)
    target=table2array(target);
    newTarget=zeros(4,size(target,1));
    for i=1:size(target,1)
        newTarget(target(i,:),i)=1;
    end

end
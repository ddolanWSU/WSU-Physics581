% Priority queue class
%
% This class implements a priority queue, building on operations defined by
% the simple queue class.  As in the latter, empty queues are constructed
% as follows.
%    object=PriorityQueue();
%
% See also SimpleQueue
%
classdef PriorityQueue < SimpleQueue
    methods       
        % copy Replicate queue
        %
        % This method copies an existing queue to a distinct object.
        %    new=copy(object);
        %
        % See also PriorityQueue
        function new=copy(object)
            backup=PriorityQueue();
            new=PriorityQueue();            
            N=0;
            while true
                value=pop(object);
                if isempty(value)
                    break
                end
                N=N+1;
                put(backup,value);
            end
            for n=1:N
                value=pop(backup);
                put(object,value);
                put(new,value);               
            end
        end
        % isempty Determine if queue is empty
        %
        % This method determines if a queue is empty
        %   flag=isempty(object);
        % Output "flag" is true when the queue is empty and false
        % otherwise.
        %
        % See also PriorityQueue
        %
        function value=isempty(object)
            temp=copy(object);
            if isempty(pop(temp))
                value=true();
            else
                value=false();
            end
        end
        % popMax Pap maximum value from queue
        %
        % This method pops the maximum value from the queue.
        %    [value,index]=popMax(object);
        % Output "value" is the largest value found in the queue.  Output
        % "index" is the location of the popped value, i.e. the first queue
        % value where the maximum value was found.
        %
        % See also PriorityQueue, pop
        %
        function [value,index]=popMax(object)
            if isempty(object)
                value=[];
                return
            end
            backup=copy(object);                       
            N=0;
            index=1;
            while true
                new=pop(object);
                if isempty(new)
                    break
                end
                N=N+1;
                if N == 1
                    previous=new;                    
                elseif new > previous
                    index=N;
                    previous=new;
                end                
            end
            for n=1:N
                temp=pop(backup);
                if n == index
                    value=temp;
                else
                    put(object,temp);
                end
            end                   
        end
        
    end
end
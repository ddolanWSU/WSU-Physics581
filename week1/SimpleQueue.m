% Simple queue class
%
% This class implemnts a simple data queue, where values are put in and
% popped out in a first in, first out (FIFO) manner.  Empty queues are
% defined as follows.
%    object=SimpleQueue();
% The queue's data type is undefined at object construction.  The Type
% property is set when the first value is put into the queue, and all
% subsequent values must match that type.  Popping out all values resets
% the Type property to 'undefined'.
%
classdef SimpleQueue < handle
    properties (SetAccess=protected, Hidden=true)
        Data % users don't need to see implementation
    end
    properties (SetAccess=protected)        
        Type = 'undefined' % Type Data type stored in queue
    end
    methods
        % put Put value into the queue
        %
        % This method puts one value at the end of the queue.
        %    put(object,value);
        % Required input "value" must be the same class as the object's
        % Type property unless the queue is empty; if so, Type is set to
        % that class.  Supported classes include numeric and character
        % scalars.
        %
        % See also SimpleQueue, pop
        %
        function put(object,value)
            assert(nargin() >= 2,'ERROR: insufficient input');
            assert(isnumeric(value) || ischar(value),...
                'ERROR: cannot put %s elements',class(value));
            assert(isscalar(value),...
                'ERROR: cannot put more than one element at a time');            
            if isempty(object.Data)
                object.Data=value;
                object.Type=class(value);
            else
                current=class(object.Data);
                assert(isa(value,current),...
                    'ERROR: put values must be %s',current);
                object.Data(end+1)=value;
            end
        end
        % pop Pop value from the queue
        %
        % This method pops one value from the front of the queue.
        %    value=pop(object);
        %
        % See also SimpleQueue, put
        %
        function value=pop(object)
            if numel(object.Data) > 0
                value=object.Data(1);
                object.Data=object.Data(2:end);
                if isempty(object.Data)
                    object.Type='undefined';
                end
            else
                value=[];
            end           
        end
    end
end
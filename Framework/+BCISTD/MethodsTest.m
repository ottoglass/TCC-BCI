classdef MethodsTest
    %UNTITLED9 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        FCN
        lalafel
    end
    methods
        function obj=MethodsTest(A)
            obj.lalafel=A;
        end
        function [somthing]=MethodFcn(obj)
            somthing=obj.FCN(obj.lalafel);
        end
    end

    
end


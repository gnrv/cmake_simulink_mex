classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(".")}) ...
  TestMex < matlab.unittest.TestCase

methods(Static)
function y = prepareModel(datatype, mexName)
  model = 'mexTestModel';
  new_system(model);
  open_system(model);
  set_param(model, ...
            'Solver', 'FixedStepDiscrete', ...  % fixed-step solver
            'FixedStep', '0.001');              % 1 ms step

  %add_block('simulink/Sources/In1', [model '/In']);
  numTimeSteps = 4; % example
  simData.time = [0 0.001 0.002 0.003]';        % example timesteps
  simData.signals.values = randn(numTimeSteps, 80, datatype); % numTimeSteps × 80
  simData.signals.dimensions = 80;              % vector width
  assignin('base','simData',simData);

  add_block('simulink/Sources/From Workspace', [model '/In'], ...
            'VariableName', 'simData');

  add_block('simulink/Sinks/Out1', [model '/Out']);
  add_block('simulink/User-Defined Functions/S-Function', [model '/SF']);
  % 'example' is the name of the mex file and the S-function within (the names must match)
  set_param([model '/SF'], 'FunctionName', mexName);

  add_line(model, 'In/1', 'SF/1');
  add_line(model, 'SF/1', 'Out/1');

  simOut = sim(model, 'SimulationMode', 'normal', 'StopTime', '0.003');
  ds = simOut.get('yout');
  y = ds.getElement(1).Values.Data;

  close_system(model, 0);
end
end

methods(Test, TestTags={'mex'})

function test_example(tc)
  y = tc.prepareModel('double', 'example');
  simData = evalin('base', 'simData');
  a=simData.signals.values;
  tc.verifyEqual(y, 2*a)
end

function test_singleExample(tc)
  y = tc.prepareModel('single', 'singleExample');
  simData = evalin('base', 'simData');
  a=simData.signals.values;
  tc.verifyEqual(y, 2*a)
end

end

end

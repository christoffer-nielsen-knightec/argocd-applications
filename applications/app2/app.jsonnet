local env = std.extVar('env');
local ingress = import '../../libs/ingress.libsonnet';
local service = import '../../libs/service.libsonnet';
local values = if env == 'dev' then import 'values/values-dev.libsonnet'
              else if env == 'qa' then import 'values/values-qa.libsonnet'
              else if env == 'stage' then import 'values/values-stage.libsonnet'
              else if env == 'prod' then import 'values/values-prod.libsonnet'
              else error 'Unsupported environment: ' + env;

local ingress = ingress.basicIngress(values);
local service = service.basicService(values);

[
    ingress,
    service
]
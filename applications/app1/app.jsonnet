local env = std.extVar('env');
local deployment = import '../../libs/deployment.libsonnet';
local ingress = import '../../libs/ingress.libsonnet';
local service = import '../../libs/service.libsonnet';
local values = if env == 'dev' then import 'values/values-dev.libsonnet'
              else if env == 'qa' then import 'values/values-qa.libsonnet'
              else if env == 'stage' then import 'values/values-stage.libsonnet'
              else if env == 'prod' then import 'values/values-prod.libsonnet'
              else error 'Unsupported environment: ' + env;

{
    "manifests": [
        deployment.basicDeployment(values),
        ingress.basicIngress(values),
        service.basicService(values)
    ]
}

//std.manifestYamlStream([
//    deployment.basicDeployment(values),
//    ingress.basicIngress(values),
//    service.basicService(values)
//], indent_array_in_object=false, c_document_end=false, quote_keys=false)

//local test = std.join('\n,', [
//    std.manifestJson(ingress.basicIngress(values)),
//    std.manifestJson(service.basicService(values))
//]);
//
//std.parseJson("[" + test + "]")

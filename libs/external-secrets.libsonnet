local values = import 'values.libsonnet';

local generateExternalSecretDataFields = function(externalSecretDataObj) {
    "key": externalSecretDataObj.KEY,
    "name": externalSecretDataObj.NAME,
};

{
  apiVersion: "kubernetes-client.io/v1",
  kind: "ExternalSecret",
  metadata: {
    name: values.INGRESS.BASIC_AUTH.SECRET_NAME,
    namespace: values.NAMESPACE
  },
  spec: {
    backendType: "systemManager",
    region: values.AWS_REGION,
    data: std.map(generateExternalSecretDataFields, values.EXTERNAL_SECRET.DATA)
  }
}
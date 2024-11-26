local deployment = import 'libs/deployment.libsonnet';
local externalSecret = import 'libs/external-secrets.libsonnet';
local ingress = import 'libs/ingress.libsonnet';
local service = import 'libs/service.libsonnet';
local values = import 'libs/values.libsonnet';

local manifests = [
    { name: "deployment.yaml", content: deployment },
    if values.INGRESS.BASIC_AUTH.ENABLED then
    { name: "external-secret.yaml", content: externalSecret }
    else null,
    { name: "ingress.yaml", content: ingress },
    { name: "service.yaml", content: service },
    { name: "values.yaml", content: values }
];

// This is a workaround to remove null values from the list
std.filter(function(x) x != null, manifests)
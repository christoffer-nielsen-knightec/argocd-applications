//local annotations = values.INGRESS.ANNOTATIONS + (if values.INGRESS.BASIC_AUTH.ENABLED then {
//                                                    'nginx.ingress.kubernetes.io/auth-type': 'basic',
//                                                    'nginx.ingress.kubernetes.io/auth-secret': values.INGRESS.BASIC_AUTH.SECRET_NAME,
//                                                  } else {});
//local values = import "values.libsonnet";

local generatePath = function(pathObj) {
  path: pathObj.PATH,
  pathType: 'Prefix',
  backend: {
    service: {
      name: pathObj.SERVICE_NAME,
      port: {
        number: pathObj.PORT,
      },
    },
  },
};

//{
//  "apiVersion": "networking.k8s.io/v1",
//  "kind": "Ingress",
//  "metadata": {
//    "name": values.APPLICATION_NAME + "-ingress",
//    "namespace": values.NAMESPACE,
//    "annotations": annotations
//  },
//  "spec": {
//    "ingressClassName": values.INGRESS.CLASS_NAME,
//    "rules": [
//      {
//        "host": values.DNS_PREFIX + values.APPLICATION_NAME + "." + values.DNS_DOMAIN,
//        "http": {
//          "paths": std.map(generatePath, values.INGRESS.PATHS)
//        }
//      }
//    ]
//  }
//}

{
  basicIngress(values, basic_auth_enabled=false):: {
    apiVersion: 'v1',
    kind: 'Ingress',
    metadata: {
      name: values.APPLICATION_NAME + '-ingress',
      namespace: values.NAMESPACE,
      annotations: values.INGRESS.ANNOTATIONS + (if basic_auth_enabled then {
                                                   'nginx.ingress.kubernetes.io/auth-type': 'basic',
                                                   'nginx.ingress.kubernetes.io/auth-secret': values.INGRESS.BASIC_AUTH.SECRET_NAME,
                                                 } else {}),
    },
    spec: {
      ingressClassName: values.INGRESS.CLASS_NAME,
      rules: [
        {
          host: values.DNS_PREFIX + values.APPLICATION_NAME + '.' + values.DNS_DOMAIN,
          http: {
            paths: std.map(generatePath, values.INGRESS.PATHS),
          },
        },
      ],
    },
  },
}

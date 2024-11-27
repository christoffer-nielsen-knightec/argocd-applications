//local annotations = values.INGRESS.ANNOTATIONS + (if values.INGRESS.BASIC_AUTH.ENABLED then {
//                                                    'nginx.ingress.kubernetes.io/auth-type': 'basic',
//                                                    'nginx.ingress.kubernetes.io/auth-secret': values.INGRESS.BASIC_AUTH.SECRET_NAME,
//                                                  } else {});
//local values = import "values.libsonnet";

local generatePath = function(pathObj) {
  Path: pathObj.PATH,
  PathType: 'Prefix',
  Backend: {
    Service: {
      Name: pathObj.SERVICE_NAME,
      Port: {
        Number: pathObj.PORT,
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
    ApiVersion: 'v1',
    Kind: 'Ingress',
    Metadata: {
      Name: values.APPLICATION_NAME + '-ingress',
      Namespace: values.NAMESPACE,
      Annotations: values.INGRESS.ANNOTATIONS + (if basic_auth_enabled then {
                                                   'nginx.ingress.kubernetes.io/auth-type': 'basic',
                                                   'nginx.ingress.kubernetes.io/auth-secret': values.INGRESS.BASIC_AUTH.SECRET_NAME,
                                                 } else {}),
    },
    Spec: {
      IngressClassName: values.INGRESS.CLASS_NAME,
      Rules: [
        {
          Host: values.DNS_PREFIX + values.APPLICATION_NAME + '.' + values.DNS_DOMAIN,
          Http: {
            Paths: std.map(generatePath, values.INGRESS.PATHS),
          },
        },
      ],
    },
  },
}

//local values = import 'values.libsonnet';

//{
//  apiVersion: "v1",
//  kind: "Service",
//  metadata: {
//    name: values.APPLICATION_NAME + "-service",
//    namespace: values.NAMESPACE,
//    labels: {
//      app: values.APPLICATION_NAME
//    }
//  },
//  spec: {
//    selector: {
//      app: values.DEPLOYMENT.POD_NAME
//    },
//    ports: [
//      {
//        port: values.SERVICE.PORT,
//        targetPort: values.SERVICE.TARGET_PORT,
//        name: "http-web"
//      }
//    ]
//  }
//}

{
  basicService(values):: {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: values.APPLICATION_NAME + '-service',
      namespace: values.NAMESPACE,
      labels: {
        app: values.APPLICATION_NAME,
      },
    },
  },
}

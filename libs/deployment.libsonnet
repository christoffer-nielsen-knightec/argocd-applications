//local values = import 'values.libsonnet';

local generateEnvVariableFields = function(envVarObj)
  if std.objectHas(envVarObj, 'VALUE_FROM') then
    {
      name: envVarObj.NAME,
      valueFrom: {
        secretKeyRef: {
          name: envVarObj.VALUE_FROM.SECRET_KEY_REF.NAME,
          key: envVarObj.VALUE_FROM.SECRET_KEY_REF.KEY,
        },
      },
    }
  else
    {
      name: envVarObj.NAME,
      value: envVarObj.VALUE,
    };

//{
//  apiVersion: 'apps/v1',
//  kind: 'Deployment',
//  metadata: {
//    name: values.APPLICATION_NAME + '-deployment',
//    namespace: values.NAMESPACE,
//  },
//  spec: {
//    selector: {
//      matchLabels: {
//        app: values.DEPLOYMENT.POD_NAME,
//      },
//    },
//    replicas: values.DEPLOYMENT.NUMBER_OF_REPLICAS,
//    template: {
//      metadata: {
//        labels: {
//          app: values.DEPLOYMENT.POD_NAME,
//        },
//      },
//      spec: {
//        containers: [
//          {
//            name: values.DEPLOYMENT.POD_NAME,
//            image: values.DEPLOYMENT.CONTAINER.IMAGE + ':' + values.DEPLOYMENT.CONTAINER.IMAGE_TAG,
//            imagePullPolicy: 'Always',
//            resources: {
//              requests: {
//                cpu: values.DEPLOYMENT.CONTAINER.RESOURCES.CPU_REQUESTS,
//              },
//              limits: {
//                memory: values.DEPLOYMENT.CONTAINER.RESOURCES.MEMORY_LIMIT,
//              },
//            },
//            ports: [
//              {
//                containerPort: values.DEPLOYMENT.CONTAINER.PORT,
//              },
//            ],
//            env: std.map(generateEnvVariableFields, values.DEPLOYMENT.CONTAINER.ENV_VARIABLES),
//          },
//        ],
//        restartPolicy: 'Always',
//      },
//    },
//  },
//}

{
  basicDeployment(values):: {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: values.APPLICATION_NAME + '-deployment',
      namespace: values.NAMESPACE,
    },
    spec: {
      selector: {
        matchLabels: {
          app: values.DEPLOYMENT.POD_NAME,
        },
      },
      replicas: values.DEPLOYMENT.NUMBER_OF_REPLICAS,
      template: {
        metadata: {
          labels: {
            app: values.DEPLOYMENT.POD_NAME,
          },
        },
        spec: {
          containers: [
            {
              name: values.DEPLOYMENT.POD_NAME,
              image: values.DEPLOYMENT.CONTAINER.IMAGE + ':' + values.DEPLOYMENT.CONTAINER.IMAGE_TAG,
              imagePullPolicy: 'Always',
              resources: {
                requests: {
                  cpu: values.DEPLOYMENT.CONTAINER.RESOURCES.CPU_REQUESTS,
                },
                limits: {
                  memory: values.DEPLOYMENT.CONTAINER.RESOURCES.MEMORY_LIMIT,
                },
              },
              ports: [
                {
                  containerPort: values.DEPLOYMENT.CONTAINER.PORT,
                },
              ],
              env: std.map(generateEnvVariableFields, values.DEPLOYMENT.CONTAINER.ENV_VARIABLES),
            },
          ],
        },
      },
    },
  },
}

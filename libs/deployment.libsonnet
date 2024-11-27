//local values = import 'values.libsonnet';

local generateEnvVariableFields = function(envVarObj)
  if std.objectHas(envVarObj, 'VALUE_FROM') then
    {
      Name: envVarObj.NAME,
      ValueFrom: {
        SecretKeyRef: {
          Name: envVarObj.VALUE_FROM.SECRET_KEY_REF.NAME,
          Key: envVarObj.VALUE_FROM.SECRET_KEY_REF.KEY,
        },
      },
    }
  else
    {
      Name: envVarObj.NAME,
      Value: envVarObj.VALUE,
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
    ApiVersion: 'apps/v1',
    Kind: 'Deployment',
    Metadata: {
      Name: values.APPLICATION_NAME + '-deployment',
      Namespace: values.NAMESPACE,
    },
    Spec: {
      Selector: {
        MatchLabels: {
          App: values.DEPLOYMENT.POD_NAME,
        },
      },
      Replicas: values.DEPLOYMENT.NUMBER_OF_REPLICAS,
      Template: {
        Metadata: {
          Labels: {
            App: values.DEPLOYMENT.POD_NAME,
          },
        },
        Spec: {
          Containers: [
            {
              Name: values.DEPLOYMENT.POD_NAME,
              Image: values.DEPLOYMENT.CONTAINER.IMAGE + ':' + values.DEPLOYMENT.CONTAINER.IMAGE_TAG,
              ImagePullPolicy: 'Always',
              Resources: {
                Requests: {
                  Cpu: values.DEPLOYMENT.CONTAINER.RESOURCES.CPU_REQUESTS,
                },
                Limits: {
                  Memory: values.DEPLOYMENT.CONTAINER.RESOURCES.MEMORY_LIMIT,
                },
              },
              Ports: [
                {
                  ContainerPort: values.DEPLOYMENT.CONTAINER.PORT,
                },
              ],
              Env: std.map(generateEnvVariableFields, values.DEPLOYMENT.CONTAINER.ENV_VARIABLES),
            },
          ],
        },
      },
    },
  },
}

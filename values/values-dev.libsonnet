local env = std.extVar('env');
local namespace = std.extVar('namespace');

{
    # ====================== Shared variables ======================
    APPLICATION_NAME: "temporary-appname",
    AWS_REGION: "eu-north-1",
    DNS_PREFIX: self.ENV + "-",
    DNS_DOMAIN: "temporary-domain.com",
    ENV: env,
    NAMESPACE: namespace,
    # ====================== Deployment variables ======================
    DEPLOYMENT: {
        POD_NAME: $["APPLICATION_NAME"] + "-pod",
        NUMBER_OF_REPLICAS: 1,
        CONTAINER: {
            IMAGE: "nginx",
            IMAGE_TAG: "latest",
            RESOURCES: {
                CPU_REQUESTS: "100m",
                MEMORY_LIMIT: "0.5Gi"
            },
            PORT: 80,
            ENV_VARIABLES: [
                {
                    NAME: "PREVIEW_SERVER_URL",
                    VALUE: "https://dev-preview-server.internal.tf-b2c.com"
                },
                {
                    NAME: "CONTAINER_CONFIG",
                    VALUE_FROM: {
                        SECRET_KEY_REF: {
                            NAME: $["APPLICATION_NAME"] + "-secrets-new",
                            KEY: "gtm-container-config"
                        }
                    }
                }
            ]
        }
    },
    # ====================== External-secret variables ======================
    EXTERNAL_SECRET: {
        DATA: [
            {
                KEY: "/" + $["ENV"] + $["INGRESS"]["BASIC_AUTH"]["SECRET_NAME"] + "-service",
                NAME: "auth"
            },
            {
                KEY: "/" + $["ENV"] + $["INGRESS"]["BASIC_AUTH"]["SECRET_NAME"] + "-service",
                NAME: "auth_service_url"
            }
        ]
    },
    # ====================== Service variables ======================
    SERVICE: {
        PORT: 80,
        TARGET_PORT: $["DEPLOYMENT"]["CONTAINER"]["PORT"],
    },
    # ====================== Ingress variables ======================
    INGRESS: {
        ANNOTATIONS: {
                "nginx.ingress.kubernetes.io/enable-cors": "true",
                "nginx.ingress.kubernetes.io/cors-allow-origin": "*"
        },
        BASIC_AUTH: {
            SECRET_NAME: "basic-auth-" + $["APPLICATION_NAME"]
        },
        CLASS_NAME: "alb-nginx-ingress",
        PATHS: [
            {
                PATH: "/",
                SERVICE_NAME: $["APPLICATION_NAME"] + "-service",
                PORT: $["SERVICE"]["PORT"]
            },
            {
                PATH: "/v1",
                SERVICE_NAME: $["APPLICATION_NAME"] + "-api-service",
                PORT: $["SERVICE"]["PORT"]
            }
        ]
    }
}
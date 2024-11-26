{
    # ====================== Shared variables ======================
    APPLICATION_NAME: "{{ .Values.APPLICATION_NAME }}",
    AWS_REGION: "{{ .Values.AWS_REGION }}",
    DNS_PREFIX: "{{ .Values.DNS_PREFIX }}-",
    DNS_DOMAIN: "{{ .Values.DNS_DOMAIN }}",
    ENV: "{{ .Values.ENV }}",
    NAMESPACE: "{{ .Values.NAMESPACE }}",
    # ====================== Deployment variables ======================
    DEPLOYMENT: {
        POD_NAME: "{{ .Values.APPLICATION_NAME }}-pod",
        NUMBER_OF_REPLICAS: "{{ .Values.DEPLOYMENT.NUMBER_OF_REPLICAS }}",
        CONTAINER: {
            IMAGE: "{{ .Values.DEPLOYMENT.CONTAINER.IMAGE }}",
            IMAGE_TAG: "{{ .Values.DEPLOYMENT.CONTAINER.IMAGE_TAG }}",
            RESOURCES: {
                CPU_REQUESTS: "{{ .Values.DEPLOYMENT.CONTAINER.RESOURCES.CPU_REQUESTS }}",
                MEMORY_LIMIT: "{{ .Values.DEPLOYMENT.CONTAINER.RESOURCES.MEMORY_LIMIT }}"
            },
            PORT: "{{ .Values.DEPLOYMENT.CONTAINER.PORT }}",
            ENV_VARIABLES: [
                {
                    NAME: "PREVIEW_SERVER_URL",
                    VALUE: "https://dev-preview-server.internal.tf-b2c.com"
                },
                {
                    NAME: "CONTAINER_CONFIG",
                    VALUE_FROM: {
                        SECRET_KEY_REF: {
                            NAME: "{{ .Values.APPLICATION_NAME }}-secrets-new",
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
                KEY: "/{{ .Values.ENV }}-{{ .Values.INGRESS.BASIC_AUTH.SECRET.NAME }}" + "-service",
                NAME: "auth"
            },
            {
                KEY: "/{{ .Values.ENV }}-{{ .Values.INGRESS.BASIC_AUTH.SECRET.NAME }}" + "-service",
                NAME: "auth_service_url"
            }
        ]
    },
    # ====================== Service variables ======================
    SERVICE: {
        PORT: "{{ .Values.SERVICE.PORT }}",
        TARGET_PORT: "{{ .Values.DEPLOYMENT.CONTAINER.PORT }}",
    },
    # ====================== Ingress variables ======================
    INGRESS: {
        ANNOTATIONS: "{{ .Values.INGRESS.ANNOTATIONS }}",
        BASIC_AUTH: {
            ENABLED: true,
            SECRET_NAME: "basic-auth-{{ .Values.APPLICATION_NAME }}"
        },
        CLASS_NAME: "{{ .Values.INGRESS.CLASS_NAME }}",
        PATHS: [
            {
                PATH: "/",
                SERVICE_NAME: "{{ .Values.APPLICATION_NAME }}-service",
                PORT: "{{ .Values.SERVICE.PORT }}"
            },
            {
                PATH: "/v1",
                SERVICE_NAME: "{{ .Values.APPLICATION_NAME }}-api-service",
                PORT: "{{ .Values.SERVICE.PORT }}"
            }
        ]
    }
}

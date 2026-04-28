# actividadclase
1. Análisis del Caso de Estudio
Tras la reciente actualización de los servicios internos, se identificó un estado de "caos operativo" debido a la falta de procesos automatizados. El software se comporta de manera impredecible entre entornos, lo que genera retrasos críticos en la entrega de valor al usuario final.

Problemas Técnicos Identificados:

Inconsistencia de Entornos ("Snowflake Servers"): Diferencias entre computadoras de desarrollo y servidores.

Principio afectado: Consistencia. Al no haber paridad, las pruebas pierden validez.

Despliegues Manuales: Procesos lentos y propensos al error humano.

Principio afectado: Automatización. Los despliegues manuales no son escalables.

Configuración Heterogénea: Los servidores no comparten una base común.

Principio afectado: Infraestructura como Código. La falta de moldes definidos impide la recuperación rápida ante fallos.

Monitoreo Reactivo: No hay visibilidad temprana de errores de desempeño.

Principio afectado: Monitoreo Continuo. El equipo depende de reportes de usuarios en lugar de alertas proactivas.


2. Estructura del Proyecto
setup_env.sh: Script de Bash para estandarizar el sistema operativo (Amazon Linux/RedHat).

resource_report.py: Script de Python para auditar recursos de infraestructura en AWS.

Dockerfile: Definición de contenedor para asegurar que la app corra igual en cualquier lugar.

infraestructura.yaml: Plantilla de CloudFormation (IaC) para crear recursos idénticos.

app.py: Aplicación simple de prueba (Flask).


3. Guía de Implementación
Ejecuta el script de Bash para instalar las dependencias necesarias y configurar Docker.

Bash
chmod +x setup_env.sh

./setup_env.sh

Verifica el estado de tu nube con el script de Python (requiere permisos de IAM o AWS CLI configurado).

Bash
pip3 install boto3

python3 resource_report.py

Construye la imagen de la aplicación para eliminar el problema de "funciona en mi máquina".

Bash
docker build -t netflix-service .

docker run -d -p 80:5000 netflix-service


4. Diseño del Pipeline CI/CD
Se propone un flujo automatizado para eliminar los despliegues manuales:

Etapa,	Herramienta,	Descripción
Source,	GitHub,	Detecta cambios en la rama main.
Build,	Docker,	Crea la imagen y la sube a Amazon ECR.
Test,	PyTest,	Ejecuta pruebas unitarias y validaciones de sintaxis.
Deploy,	AWS CodeDeploy,	Despliegue progresivo en EC2/ECS sin tiempo de inactividad.
Monitoreo,	CloudWatch,	Vigila métricas de salud inmediatamente tras el despliegue.


5. Monitoreo y Respuesta
Se configuran las siguientes métricas en Amazon CloudWatch:

CPU Utilization: Si supera el 80%, se dispara un escalado automático.

HTTP 5XX Errors: Si hay más de 5 errores por minuto, se realiza un rollback automático a la versión estable anterior.

Latency: Si el tiempo de respuesta es >200ms, se envía una alerta al equipo vía SNS/Slack.


6. Conclusión de la Propuesta
Mejora: Esta solución transforma un proceso artesanal en una línea de ensamblaje industrial, reduciendo el error humano en un 90% y garantizando que el software sea portátil.

Dificultad: Lo más complejo en una empresa real es la migración de aplicaciones legacy (antiguas) hacia contenedores Docker.

Beneficio a Mediano Plazo: Escalabilidad infinita. Netflix podrá lanzar nuevas versiones varias veces al día con la confianza de que el entorno es estable y monitoreado.

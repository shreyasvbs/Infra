{{/*
========================================================
Application name
========================================================
*/}}

{{- define "three-tier-app.name" -}}
{{- default .Chart.Name .Values.global.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
========================================================
Full application name
========================================================
*/}}

{{- define "three-tier-app.fullname" -}}

{{- if .Values.global.fullnameOverride }}

{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" }}

{{- else }}

{{- $name := include "three-tier-app.name" . }}

{{- if contains $name .Release.Name }}

{{- .Release.Name | trunc 63 | trimSuffix "-" }}

{{- else }}

{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}

{{- end }}

{{- end }}

{{- end }}


{{/*
========================================================
Common labels
========================================================
*/}}

{{- define "three-tier-app.labels" -}}

helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}

app.kubernetes.io/name: {{ include "three-tier-app.name" . }}

app.kubernetes.io/instance: {{ .Release.Name }}

app.kubernetes.io/managed-by: {{ .Release.Service }}

{{- end }}


{{/*
========================================================
Frontend ingress path
========================================================
*/}}

{{- define "three-tier-app.ingress.frontendPath" -}}
{{- default "/" .Values.global.ingress.paths.frontend }}
{{- end }}


{{/*
========================================================
Backend ingress path
========================================================
*/}}

{{- define "three-tier-app.ingress.backendPath" -}}
{{- default "/api" .Values.global.ingress.paths.backend }}
{{- end }}


{{/*
========================================================
Frontend service name
========================================================
*/}}

{{- define "three-tier-app.frontendService" -}}
{{ include "three-tier-app.fullname" . }}-frontend
{{- end }}


{{/*
========================================================
Backend service name
========================================================
*/}}

{{- define "three-tier-app.backendService" -}}
{{ include "three-tier-app.fullname" . }}-backend
{{- end }}


{{/*
========================================================
PostgreSQL service name
========================================================
*/}}

{{- define "three-tier-app.postgresService" -}}
{{ include "three-tier-app.fullname" . }}-postgresql
{{- end }}
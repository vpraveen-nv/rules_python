# Install pip requirements.
#
# Generated from /home/lpeltonen/go/src/github.com/bazelbuild/rules_python/examples/checked_in_requirements_bzl/requirements.txt

load("@examples_checked_in_requirements_bzl//python:whl.bzl", _whl_library = "whl_library")

_requirements = {
  "botocore": "@examples_checked_in_requirements_bzl__botocore_1_10_4//:pkg",
  "botocore:dirty": "@examples_checked_in_requirements_bzl__botocore_1_10_4_dirty//:pkg",
  "cachetools": "@examples_checked_in_requirements_bzl__cachetools_2_0_1//:pkg",
  "cachetools:dirty": "@examples_checked_in_requirements_bzl__cachetools_2_0_1_dirty//:pkg",
  "certifi": "@examples_checked_in_requirements_bzl__certifi_2018_4_16//:pkg",
  "certifi:dirty": "@examples_checked_in_requirements_bzl__certifi_2018_4_16_dirty//:pkg",
  "chardet": "@examples_checked_in_requirements_bzl__chardet_3_0_4//:pkg",
  "chardet:dirty": "@examples_checked_in_requirements_bzl__chardet_3_0_4_dirty//:pkg",
  "dill": "@examples_checked_in_requirements_bzl__dill_0_2_7_1//:pkg",
  "dill:dirty": "@examples_checked_in_requirements_bzl__dill_0_2_7_1_dirty//:pkg",
  "docutils": "@examples_checked_in_requirements_bzl__docutils_0_14//:pkg",
  "docutils:dirty": "@examples_checked_in_requirements_bzl__docutils_0_14_dirty//:pkg",
  "enum34": "@examples_checked_in_requirements_bzl__enum34_1_1_6//:pkg",
  "enum34:dirty": "@examples_checked_in_requirements_bzl__enum34_1_1_6_dirty//:pkg",
  "future": "@examples_checked_in_requirements_bzl__future_0_16_0//:pkg",
  "future:dirty": "@examples_checked_in_requirements_bzl__future_0_16_0_dirty//:pkg",
  "futures": "@examples_checked_in_requirements_bzl__futures_3_2_0//:pkg",
  "futures:dirty": "@examples_checked_in_requirements_bzl__futures_3_2_0_dirty//:pkg",
  "gapic-google-cloud-datastore-v1": "@examples_checked_in_requirements_bzl__gapic_google_cloud_datastore_v1_0_15_3//:pkg",
  "gapic-google-cloud-datastore-v1:dirty": "@examples_checked_in_requirements_bzl__gapic_google_cloud_datastore_v1_0_15_3_dirty//:pkg",
  "gapic-google-cloud-error-reporting-v1beta1": "@examples_checked_in_requirements_bzl__gapic_google_cloud_error_reporting_v1beta1_0_15_3//:pkg",
  "gapic-google-cloud-error-reporting-v1beta1:dirty": "@examples_checked_in_requirements_bzl__gapic_google_cloud_error_reporting_v1beta1_0_15_3_dirty//:pkg",
  "gapic-google-cloud-logging-v2": "@examples_checked_in_requirements_bzl__gapic_google_cloud_logging_v2_0_91_3//:pkg",
  "gapic-google-cloud-logging-v2:dirty": "@examples_checked_in_requirements_bzl__gapic_google_cloud_logging_v2_0_91_3_dirty//:pkg",
  "google-api-core": "@examples_checked_in_requirements_bzl__google_api_core_0_1_4//:pkg",
  "google-api-core:dirty": "@examples_checked_in_requirements_bzl__google_api_core_0_1_4_dirty//:pkg",
  "google-api-core[grpc]": "@examples_checked_in_requirements_bzl__google_api_core_0_1_4//:grpc",
  "google-api-core:dirty[grpc]": "@examples_checked_in_requirements_bzl__google_api_core_0_1_4_dirty//:grpc",
  "google-auth": "@examples_checked_in_requirements_bzl__google_auth_1_4_1//:pkg",
  "google-auth:dirty": "@examples_checked_in_requirements_bzl__google_auth_1_4_1_dirty//:pkg",
  "google-cloud": "@examples_checked_in_requirements_bzl__google_cloud_0_29_0//:pkg",
  "google-cloud:dirty": "@examples_checked_in_requirements_bzl__google_cloud_0_29_0_dirty//:pkg",
  "google-cloud-bigquery": "@examples_checked_in_requirements_bzl__google_cloud_bigquery_0_28_0//:pkg",
  "google-cloud-bigquery:dirty": "@examples_checked_in_requirements_bzl__google_cloud_bigquery_0_28_0_dirty//:pkg",
  "google-cloud-bigtable": "@examples_checked_in_requirements_bzl__google_cloud_bigtable_0_28_1//:pkg",
  "google-cloud-bigtable:dirty": "@examples_checked_in_requirements_bzl__google_cloud_bigtable_0_28_1_dirty//:pkg",
  "google-cloud-core": "@examples_checked_in_requirements_bzl__google_cloud_core_0_28_1//:pkg",
  "google-cloud-core:dirty": "@examples_checked_in_requirements_bzl__google_cloud_core_0_28_1_dirty//:pkg",
  "google-cloud-core[grpc]": "@examples_checked_in_requirements_bzl__google_cloud_core_0_28_1//:grpc",
  "google-cloud-core:dirty[grpc]": "@examples_checked_in_requirements_bzl__google_cloud_core_0_28_1_dirty//:grpc",
  "google-cloud-datastore": "@examples_checked_in_requirements_bzl__google_cloud_datastore_1_4_0//:pkg",
  "google-cloud-datastore:dirty": "@examples_checked_in_requirements_bzl__google_cloud_datastore_1_4_0_dirty//:pkg",
  "google-cloud-dns": "@examples_checked_in_requirements_bzl__google_cloud_dns_0_28_0//:pkg",
  "google-cloud-dns:dirty": "@examples_checked_in_requirements_bzl__google_cloud_dns_0_28_0_dirty//:pkg",
  "google-cloud-error-reporting": "@examples_checked_in_requirements_bzl__google_cloud_error_reporting_0_28_0//:pkg",
  "google-cloud-error-reporting:dirty": "@examples_checked_in_requirements_bzl__google_cloud_error_reporting_0_28_0_dirty//:pkg",
  "google-cloud-firestore": "@examples_checked_in_requirements_bzl__google_cloud_firestore_0_28_0//:pkg",
  "google-cloud-firestore:dirty": "@examples_checked_in_requirements_bzl__google_cloud_firestore_0_28_0_dirty//:pkg",
  "google-cloud-language": "@examples_checked_in_requirements_bzl__google_cloud_language_0_31_0//:pkg",
  "google-cloud-language:dirty": "@examples_checked_in_requirements_bzl__google_cloud_language_0_31_0_dirty//:pkg",
  "google-cloud-logging": "@examples_checked_in_requirements_bzl__google_cloud_logging_1_4_0//:pkg",
  "google-cloud-logging:dirty": "@examples_checked_in_requirements_bzl__google_cloud_logging_1_4_0_dirty//:pkg",
  "google-cloud-monitoring": "@examples_checked_in_requirements_bzl__google_cloud_monitoring_0_28_1//:pkg",
  "google-cloud-monitoring:dirty": "@examples_checked_in_requirements_bzl__google_cloud_monitoring_0_28_1_dirty//:pkg",
  "google-cloud-pubsub": "@examples_checked_in_requirements_bzl__google_cloud_pubsub_0_29_4//:pkg",
  "google-cloud-pubsub:dirty": "@examples_checked_in_requirements_bzl__google_cloud_pubsub_0_29_4_dirty//:pkg",
  "google-cloud-resource-manager": "@examples_checked_in_requirements_bzl__google_cloud_resource_manager_0_28_1//:pkg",
  "google-cloud-resource-manager:dirty": "@examples_checked_in_requirements_bzl__google_cloud_resource_manager_0_28_1_dirty//:pkg",
  "google-cloud-runtimeconfig": "@examples_checked_in_requirements_bzl__google_cloud_runtimeconfig_0_28_1//:pkg",
  "google-cloud-runtimeconfig:dirty": "@examples_checked_in_requirements_bzl__google_cloud_runtimeconfig_0_28_1_dirty//:pkg",
  "google-cloud-spanner": "@examples_checked_in_requirements_bzl__google_cloud_spanner_0_29_0//:pkg",
  "google-cloud-spanner:dirty": "@examples_checked_in_requirements_bzl__google_cloud_spanner_0_29_0_dirty//:pkg",
  "google-cloud-speech": "@examples_checked_in_requirements_bzl__google_cloud_speech_0_30_0//:pkg",
  "google-cloud-speech:dirty": "@examples_checked_in_requirements_bzl__google_cloud_speech_0_30_0_dirty//:pkg",
  "google-cloud-storage": "@examples_checked_in_requirements_bzl__google_cloud_storage_1_6_0//:pkg",
  "google-cloud-storage:dirty": "@examples_checked_in_requirements_bzl__google_cloud_storage_1_6_0_dirty//:pkg",
  "google-cloud-trace": "@examples_checked_in_requirements_bzl__google_cloud_trace_0_16_0//:pkg",
  "google-cloud-trace:dirty": "@examples_checked_in_requirements_bzl__google_cloud_trace_0_16_0_dirty//:pkg",
  "google-cloud-translate": "@examples_checked_in_requirements_bzl__google_cloud_translate_1_3_1//:pkg",
  "google-cloud-translate:dirty": "@examples_checked_in_requirements_bzl__google_cloud_translate_1_3_1_dirty//:pkg",
  "google-cloud-videointelligence": "@examples_checked_in_requirements_bzl__google_cloud_videointelligence_0_28_0//:pkg",
  "google-cloud-videointelligence:dirty": "@examples_checked_in_requirements_bzl__google_cloud_videointelligence_0_28_0_dirty//:pkg",
  "google-cloud-vision": "@examples_checked_in_requirements_bzl__google_cloud_vision_0_28_0//:pkg",
  "google-cloud-vision:dirty": "@examples_checked_in_requirements_bzl__google_cloud_vision_0_28_0_dirty//:pkg",
  "google-gax": "@examples_checked_in_requirements_bzl__google_gax_0_15_16//:pkg",
  "google-gax:dirty": "@examples_checked_in_requirements_bzl__google_gax_0_15_16_dirty//:pkg",
  "google-resumable-media": "@examples_checked_in_requirements_bzl__google_resumable_media_0_3_1//:pkg",
  "google-resumable-media:dirty": "@examples_checked_in_requirements_bzl__google_resumable_media_0_3_1_dirty//:pkg",
  "google-resumable-media[requests]": "@examples_checked_in_requirements_bzl__google_resumable_media_0_3_1//:requests",
  "google-resumable-media:dirty[requests]": "@examples_checked_in_requirements_bzl__google_resumable_media_0_3_1_dirty//:requests",
  "googleapis-common-protos": "@examples_checked_in_requirements_bzl__googleapis_common_protos_1_5_3//:pkg",
  "googleapis-common-protos:dirty": "@examples_checked_in_requirements_bzl__googleapis_common_protos_1_5_3_dirty//:pkg",
  "googleapis-common-protos[grpc]": "@examples_checked_in_requirements_bzl__googleapis_common_protos_1_5_3//:grpc",
  "googleapis-common-protos:dirty[grpc]": "@examples_checked_in_requirements_bzl__googleapis_common_protos_1_5_3_dirty//:grpc",
  "grpc-google-iam-v1": "@examples_checked_in_requirements_bzl__grpc_google_iam_v1_0_11_4//:pkg",
  "grpc-google-iam-v1:dirty": "@examples_checked_in_requirements_bzl__grpc_google_iam_v1_0_11_4_dirty//:pkg",
  "grpcio": "@examples_checked_in_requirements_bzl__grpcio_1_11_0//:pkg",
  "grpcio:dirty": "@examples_checked_in_requirements_bzl__grpcio_1_11_0_dirty//:pkg",
  "httplib2": "@examples_checked_in_requirements_bzl__httplib2_0_11_3//:pkg",
  "httplib2:dirty": "@examples_checked_in_requirements_bzl__httplib2_0_11_3_dirty//:pkg",
  "idna": "@examples_checked_in_requirements_bzl__idna_2_6//:pkg",
  "idna:dirty": "@examples_checked_in_requirements_bzl__idna_2_6_dirty//:pkg",
  "jmespath": "@examples_checked_in_requirements_bzl__jmespath_0_9_3//:pkg",
  "jmespath:dirty": "@examples_checked_in_requirements_bzl__jmespath_0_9_3_dirty//:pkg",
  "numpy": "@examples_checked_in_requirements_bzl__numpy_1_14_2//:pkg",
  "numpy:dirty": "@examples_checked_in_requirements_bzl__numpy_1_14_2_dirty//:pkg",
  "oauth2client": "@examples_checked_in_requirements_bzl__oauth2client_3_0_0//:pkg",
  "oauth2client:dirty": "@examples_checked_in_requirements_bzl__oauth2client_3_0_0_dirty//:pkg",
  "pip": "@examples_checked_in_requirements_bzl__pip_9_0_0//:pkg",
  "pip:dirty": "@examples_checked_in_requirements_bzl__pip_9_0_0_dirty//:pkg",
  "ply": "@examples_checked_in_requirements_bzl__ply_3_8//:pkg",
  "ply:dirty": "@examples_checked_in_requirements_bzl__ply_3_8_dirty//:pkg",
  "proto-google-cloud-datastore-v1": "@examples_checked_in_requirements_bzl__proto_google_cloud_datastore_v1_0_90_4//:pkg",
  "proto-google-cloud-datastore-v1:dirty": "@examples_checked_in_requirements_bzl__proto_google_cloud_datastore_v1_0_90_4_dirty//:pkg",
  "proto-google-cloud-datastore-v1[grpc]": "@examples_checked_in_requirements_bzl__proto_google_cloud_datastore_v1_0_90_4//:grpc",
  "proto-google-cloud-datastore-v1:dirty[grpc]": "@examples_checked_in_requirements_bzl__proto_google_cloud_datastore_v1_0_90_4_dirty//:grpc",
  "proto-google-cloud-error-reporting-v1beta1": "@examples_checked_in_requirements_bzl__proto_google_cloud_error_reporting_v1beta1_0_15_3//:pkg",
  "proto-google-cloud-error-reporting-v1beta1:dirty": "@examples_checked_in_requirements_bzl__proto_google_cloud_error_reporting_v1beta1_0_15_3_dirty//:pkg",
  "proto-google-cloud-error-reporting-v1beta1[grpc]": "@examples_checked_in_requirements_bzl__proto_google_cloud_error_reporting_v1beta1_0_15_3//:grpc",
  "proto-google-cloud-error-reporting-v1beta1:dirty[grpc]": "@examples_checked_in_requirements_bzl__proto_google_cloud_error_reporting_v1beta1_0_15_3_dirty//:grpc",
  "proto-google-cloud-logging-v2": "@examples_checked_in_requirements_bzl__proto_google_cloud_logging_v2_0_91_3//:pkg",
  "proto-google-cloud-logging-v2:dirty": "@examples_checked_in_requirements_bzl__proto_google_cloud_logging_v2_0_91_3_dirty//:pkg",
  "proto-google-cloud-logging-v2[grpc]": "@examples_checked_in_requirements_bzl__proto_google_cloud_logging_v2_0_91_3//:grpc",
  "proto-google-cloud-logging-v2:dirty[grpc]": "@examples_checked_in_requirements_bzl__proto_google_cloud_logging_v2_0_91_3_dirty//:grpc",
  "protobuf": "@examples_checked_in_requirements_bzl__protobuf_3_5_2_post1//:pkg",
  "protobuf:dirty": "@examples_checked_in_requirements_bzl__protobuf_3_5_2_post1_dirty//:pkg",
  "psutil": "@examples_checked_in_requirements_bzl__psutil_5_4_5//:pkg",
  "psutil:dirty": "@examples_checked_in_requirements_bzl__psutil_5_4_5_dirty//:pkg",
  "psutil[enum]": "@examples_checked_in_requirements_bzl__psutil_5_4_5//:enum",
  "psutil:dirty[enum]": "@examples_checked_in_requirements_bzl__psutil_5_4_5_dirty//:enum",
  "pyasn1": "@examples_checked_in_requirements_bzl__pyasn1_0_4_2//:pkg",
  "pyasn1:dirty": "@examples_checked_in_requirements_bzl__pyasn1_0_4_2_dirty//:pkg",
  "pyasn1-modules": "@examples_checked_in_requirements_bzl__pyasn1_modules_0_2_1//:pkg",
  "pyasn1-modules:dirty": "@examples_checked_in_requirements_bzl__pyasn1_modules_0_2_1_dirty//:pkg",
  "python-dateutil": "@examples_checked_in_requirements_bzl__python_dateutil_2_6_1//:pkg",
  "python-dateutil:dirty": "@examples_checked_in_requirements_bzl__python_dateutil_2_6_1_dirty//:pkg",
  "pytz": "@examples_checked_in_requirements_bzl__pytz_2018_4//:pkg",
  "pytz:dirty": "@examples_checked_in_requirements_bzl__pytz_2018_4_dirty//:pkg",
  "requests": "@examples_checked_in_requirements_bzl__requests_2_18_4//:pkg",
  "requests:dirty": "@examples_checked_in_requirements_bzl__requests_2_18_4_dirty//:pkg",
  "rsa": "@examples_checked_in_requirements_bzl__rsa_3_4_2//:pkg",
  "rsa:dirty": "@examples_checked_in_requirements_bzl__rsa_3_4_2_dirty//:pkg",
  "scikit-learn": "@examples_checked_in_requirements_bzl__scikit_learn_0_17_1//:pkg",
  "scikit-learn:dirty": "@examples_checked_in_requirements_bzl__scikit_learn_0_17_1_dirty//:pkg",
  "scipy": "@examples_checked_in_requirements_bzl__scipy_0_17_1//:pkg",
  "scipy:dirty": "@examples_checked_in_requirements_bzl__scipy_0_17_1_dirty//:pkg",
  "setuptools": "@examples_checked_in_requirements_bzl__setuptools_39_0_1//:pkg",
  "setuptools:dirty": "@examples_checked_in_requirements_bzl__setuptools_39_0_1_dirty//:pkg",
  "setuptools[certs]": "@examples_checked_in_requirements_bzl__setuptools_39_0_1//:certs",
  "setuptools:dirty[certs]": "@examples_checked_in_requirements_bzl__setuptools_39_0_1_dirty//:certs",
  "setuptools[ssl]": "@examples_checked_in_requirements_bzl__setuptools_39_0_1//:ssl",
  "setuptools:dirty[ssl]": "@examples_checked_in_requirements_bzl__setuptools_39_0_1_dirty//:ssl",
  "six": "@examples_checked_in_requirements_bzl__six_1_11_0//:pkg",
  "six:dirty": "@examples_checked_in_requirements_bzl__six_1_11_0_dirty//:pkg",
  "urllib3": "@examples_checked_in_requirements_bzl__urllib3_1_22//:pkg",
  "urllib3:dirty": "@examples_checked_in_requirements_bzl__urllib3_1_22_dirty//:pkg"
}

_wheels = {
  "botocore": "@examples_checked_in_requirements_bzl__botocore_1_10_4_wheel//:botocore-1.10.4-py2.py3-none-any.whl",
  "cachetools": "@examples_checked_in_requirements_bzl__cachetools_2_0_1_wheel//:cachetools-2.0.1-py2.py3-none-any.whl",
  "certifi": "@examples_checked_in_requirements_bzl__certifi_2018_4_16_wheel//:certifi-2018.4.16-py2.py3-none-any.whl",
  "chardet": "@examples_checked_in_requirements_bzl__chardet_3_0_4_wheel//:chardet-3.0.4-py2.py3-none-any.whl",
  "dill": "@examples_checked_in_requirements_bzl__dill_0_2_7_1_wheel//:dill-0.2.7.1-py2-none-any.whl",
  "docutils": "@examples_checked_in_requirements_bzl__docutils_0_14_wheel//:docutils-0.14-py2-none-any.whl",
  "enum34": "@examples_checked_in_requirements_bzl__enum34_1_1_6_wheel//:enum34-1.1.6-py2-none-any.whl",
  "future": "@examples_checked_in_requirements_bzl__future_0_16_0_wheel//:future-0.16.0-py2-none-any.whl",
  "futures": "@examples_checked_in_requirements_bzl__futures_3_2_0_wheel//:futures-3.2.0-py2-none-any.whl",
  "gapic-google-cloud-datastore-v1": "@examples_checked_in_requirements_bzl__gapic_google_cloud_datastore_v1_0_15_3_wheel//:gapic_google_cloud_datastore_v1-0.15.3-py2-none-any.whl",
  "gapic-google-cloud-error-reporting-v1beta1": "@examples_checked_in_requirements_bzl__gapic_google_cloud_error_reporting_v1beta1_0_15_3_wheel//:gapic_google_cloud_error_reporting_v1beta1-0.15.3-py2-none-any.whl",
  "gapic-google-cloud-logging-v2": "@examples_checked_in_requirements_bzl__gapic_google_cloud_logging_v2_0_91_3_wheel//:gapic_google_cloud_logging_v2-0.91.3-py2-none-any.whl",
  "google-api-core": "@examples_checked_in_requirements_bzl__google_api_core_0_1_4_wheel//:google_api_core-0.1.4-py2.py3-none-any.whl",
  "google-auth": "@examples_checked_in_requirements_bzl__google_auth_1_4_1_wheel//:google_auth-1.4.1-py2.py3-none-any.whl",
  "google-cloud": "@examples_checked_in_requirements_bzl__google_cloud_0_29_0_wheel//:google_cloud-0.29.0-py2.py3-none-any.whl",
  "google-cloud-bigquery": "@examples_checked_in_requirements_bzl__google_cloud_bigquery_0_28_0_wheel//:google_cloud_bigquery-0.28.0-py2.py3-none-any.whl",
  "google-cloud-bigtable": "@examples_checked_in_requirements_bzl__google_cloud_bigtable_0_28_1_wheel//:google_cloud_bigtable-0.28.1-py2.py3-none-any.whl",
  "google-cloud-core": "@examples_checked_in_requirements_bzl__google_cloud_core_0_28_1_wheel//:google_cloud_core-0.28.1-py2.py3-none-any.whl",
  "google-cloud-datastore": "@examples_checked_in_requirements_bzl__google_cloud_datastore_1_4_0_wheel//:google_cloud_datastore-1.4.0-py2.py3-none-any.whl",
  "google-cloud-dns": "@examples_checked_in_requirements_bzl__google_cloud_dns_0_28_0_wheel//:google_cloud_dns-0.28.0-py2.py3-none-any.whl",
  "google-cloud-error-reporting": "@examples_checked_in_requirements_bzl__google_cloud_error_reporting_0_28_0_wheel//:google_cloud_error_reporting-0.28.0-py2.py3-none-any.whl",
  "google-cloud-firestore": "@examples_checked_in_requirements_bzl__google_cloud_firestore_0_28_0_wheel//:google_cloud_firestore-0.28.0-py2.py3-none-any.whl",
  "google-cloud-language": "@examples_checked_in_requirements_bzl__google_cloud_language_0_31_0_wheel//:google_cloud_language-0.31.0-py2.py3-none-any.whl",
  "google-cloud-logging": "@examples_checked_in_requirements_bzl__google_cloud_logging_1_4_0_wheel//:google_cloud_logging-1.4.0-py2.py3-none-any.whl",
  "google-cloud-monitoring": "@examples_checked_in_requirements_bzl__google_cloud_monitoring_0_28_1_wheel//:google_cloud_monitoring-0.28.1-py2.py3-none-any.whl",
  "google-cloud-pubsub": "@examples_checked_in_requirements_bzl__google_cloud_pubsub_0_29_4_wheel//:google_cloud_pubsub-0.29.4-py2.py3-none-any.whl",
  "google-cloud-resource-manager": "@examples_checked_in_requirements_bzl__google_cloud_resource_manager_0_28_1_wheel//:google_cloud_resource_manager-0.28.1-py2.py3-none-any.whl",
  "google-cloud-runtimeconfig": "@examples_checked_in_requirements_bzl__google_cloud_runtimeconfig_0_28_1_wheel//:google_cloud_runtimeconfig-0.28.1-py2.py3-none-any.whl",
  "google-cloud-spanner": "@examples_checked_in_requirements_bzl__google_cloud_spanner_0_29_0_wheel//:google_cloud_spanner-0.29.0-py2.py3-none-any.whl",
  "google-cloud-speech": "@examples_checked_in_requirements_bzl__google_cloud_speech_0_30_0_wheel//:google_cloud_speech-0.30.0-py2.py3-none-any.whl",
  "google-cloud-storage": "@examples_checked_in_requirements_bzl__google_cloud_storage_1_6_0_wheel//:google_cloud_storage-1.6.0-py2.py3-none-any.whl",
  "google-cloud-trace": "@examples_checked_in_requirements_bzl__google_cloud_trace_0_16_0_wheel//:google_cloud_trace-0.16.0-py2-none-any.whl",
  "google-cloud-translate": "@examples_checked_in_requirements_bzl__google_cloud_translate_1_3_1_wheel//:google_cloud_translate-1.3.1-py2.py3-none-any.whl",
  "google-cloud-videointelligence": "@examples_checked_in_requirements_bzl__google_cloud_videointelligence_0_28_0_wheel//:google_cloud_videointelligence-0.28.0-py2.py3-none-any.whl",
  "google-cloud-vision": "@examples_checked_in_requirements_bzl__google_cloud_vision_0_28_0_wheel//:google_cloud_vision-0.28.0-py2.py3-none-any.whl",
  "google-gax": "@examples_checked_in_requirements_bzl__google_gax_0_15_16_wheel//:google_gax-0.15.16-py2.py3-none-any.whl",
  "google-resumable-media": "@examples_checked_in_requirements_bzl__google_resumable_media_0_3_1_wheel//:google_resumable_media-0.3.1-py2.py3-none-any.whl",
  "googleapis-common-protos": "@examples_checked_in_requirements_bzl__googleapis_common_protos_1_5_3_wheel//:googleapis_common_protos-1.5.3-py2-none-any.whl",
  "grpc-google-iam-v1": "@examples_checked_in_requirements_bzl__grpc_google_iam_v1_0_11_4_wheel//:grpc_google_iam_v1-0.11.4-py2-none-any.whl",
  "grpcio": "@examples_checked_in_requirements_bzl__grpcio_1_11_0_wheel//:grpcio-1.11.0-cp27-cp27mu-manylinux1_x86_64.whl",
  "httplib2": "@examples_checked_in_requirements_bzl__httplib2_0_11_3_wheel//:httplib2-0.11.3-py2-none-any.whl",
  "idna": "@examples_checked_in_requirements_bzl__idna_2_6_wheel//:idna-2.6-py2.py3-none-any.whl",
  "jmespath": "@examples_checked_in_requirements_bzl__jmespath_0_9_3_wheel//:jmespath-0.9.3-py2.py3-none-any.whl",
  "numpy": "@examples_checked_in_requirements_bzl__numpy_1_14_2_wheel//:numpy-1.14.2-cp27-cp27mu-manylinux1_x86_64.whl",
  "oauth2client": "@examples_checked_in_requirements_bzl__oauth2client_3_0_0_wheel//:oauth2client-3.0.0-py2-none-any.whl",
  "pip": "@examples_checked_in_requirements_bzl__pip_9_0_0_wheel//:pip-9.0.0-py2.py3-none-any.whl",
  "ply": "@examples_checked_in_requirements_bzl__ply_3_8_wheel//:ply-3.8-py2.py3-none-any.whl",
  "proto-google-cloud-datastore-v1": "@examples_checked_in_requirements_bzl__proto_google_cloud_datastore_v1_0_90_4_wheel//:proto_google_cloud_datastore_v1-0.90.4-py2-none-any.whl",
  "proto-google-cloud-error-reporting-v1beta1": "@examples_checked_in_requirements_bzl__proto_google_cloud_error_reporting_v1beta1_0_15_3_wheel//:proto_google_cloud_error_reporting_v1beta1-0.15.3-py2-none-any.whl",
  "proto-google-cloud-logging-v2": "@examples_checked_in_requirements_bzl__proto_google_cloud_logging_v2_0_91_3_wheel//:proto_google_cloud_logging_v2-0.91.3-py2-none-any.whl",
  "protobuf": "@examples_checked_in_requirements_bzl__protobuf_3_5_2_post1_wheel//:protobuf-3.5.2.post1-cp27-cp27mu-manylinux1_x86_64.whl",
  "psutil": "@examples_checked_in_requirements_bzl__psutil_5_4_5_wheel//:psutil-5.4.5-cp27-cp27mu-linux_x86_64.whl",
  "pyasn1": "@examples_checked_in_requirements_bzl__pyasn1_0_4_2_wheel//:pyasn1-0.4.2-py2.py3-none-any.whl",
  "pyasn1-modules": "@examples_checked_in_requirements_bzl__pyasn1_modules_0_2_1_wheel//:pyasn1_modules-0.2.1-py2.py3-none-any.whl",
  "python-dateutil": "@examples_checked_in_requirements_bzl__python_dateutil_2_6_1_wheel//:python_dateutil-2.6.1-py2.py3-none-any.whl",
  "pytz": "@examples_checked_in_requirements_bzl__pytz_2018_4_wheel//:pytz-2018.4-py2.py3-none-any.whl",
  "requests": "@examples_checked_in_requirements_bzl__requests_2_18_4_wheel//:requests-2.18.4-py2.py3-none-any.whl",
  "rsa": "@examples_checked_in_requirements_bzl__rsa_3_4_2_wheel//:rsa-3.4.2-py2.py3-none-any.whl",
  "scikit-learn": "@examples_checked_in_requirements_bzl__scikit_learn_0_17_1_wheel//:scikit_learn-0.17.1-cp27-cp27mu-manylinux1_x86_64.whl",
  "scipy": "@examples_checked_in_requirements_bzl__scipy_0_17_1_wheel//:scipy-0.17.1-cp27-cp27mu-manylinux1_x86_64.whl",
  "setuptools": "@examples_checked_in_requirements_bzl__setuptools_39_0_1_wheel//:setuptools-39.0.1-py2.py3-none-any.whl",
  "six": "@examples_checked_in_requirements_bzl__six_1_11_0_wheel//:six-1.11.0-py2.py3-none-any.whl",
  "urllib3": "@examples_checked_in_requirements_bzl__urllib3_1_22_wheel//:urllib3-1.22-py2.py3-none-any.whl"
}

all_requirements = _requirements.values()

def requirement(name):
  if name not in _requirements:
    fail("Could not find pip-provided dependency: '%s'" % name)
  return _requirements[name]

def whl_library(**kwargs):
  _whl_library(wheels_map=_wheels, **kwargs)

def pip_install():

  whl_library(
    requirement = "botocore==1.10.4",
    name = "examples_checked_in_requirements_bzl__botocore_1_10_4",
    runtime_deps = ["python-dateutil", "docutils", "jmespath"],
  )

  whl_library(
    requirement = "cachetools==2.0.1",
    name = "examples_checked_in_requirements_bzl__cachetools_2_0_1",
  )

  whl_library(
    requirement = "certifi==2018.4.16",
    name = "examples_checked_in_requirements_bzl__certifi_2018_4_16",
  )

  whl_library(
    requirement = "chardet==3.0.4",
    name = "examples_checked_in_requirements_bzl__chardet_3_0_4",
  )

  whl_library(
    requirement = "dill==0.2.7.1",
    name = "examples_checked_in_requirements_bzl__dill_0_2_7_1",
  )

  whl_library(
    requirement = "docutils==0.14",
    name = "examples_checked_in_requirements_bzl__docutils_0_14",
  )

  whl_library(
    requirement = "enum34==1.1.6",
    name = "examples_checked_in_requirements_bzl__enum34_1_1_6",
  )

  whl_library(
    requirement = "future==0.16.0",
    name = "examples_checked_in_requirements_bzl__future_0_16_0",
  )

  whl_library(
    requirement = "futures==3.2.0",
    name = "examples_checked_in_requirements_bzl__futures_3_2_0",
  )

  whl_library(
    requirement = "gapic-google-cloud-datastore-v1==0.15.3",
    name = "examples_checked_in_requirements_bzl__gapic_google_cloud_datastore_v1_0_15_3",
    runtime_deps = ["oauth2client", "google-gax", "googleapis-common-protos[grpc]", "proto-google-cloud-datastore-v1[grpc]"],
  )

  whl_library(
    requirement = "gapic-google-cloud-error-reporting-v1beta1==0.15.3",
    name = "examples_checked_in_requirements_bzl__gapic_google_cloud_error_reporting_v1beta1_0_15_3",
    runtime_deps = ["oauth2client", "google-gax", "googleapis-common-protos[grpc]", "proto-google-cloud-error-reporting-v1beta1[grpc]"],
  )

  whl_library(
    requirement = "gapic-google-cloud-logging-v2==0.91.3",
    name = "examples_checked_in_requirements_bzl__gapic_google_cloud_logging_v2_0_91_3",
    runtime_deps = ["proto-google-cloud-logging-v2[grpc]", "oauth2client", "google-gax", "googleapis-common-protos[grpc]"],
  )

  whl_library(
    requirement = "google-api-core==0.1.4",
    extras = ["grpc"],
    name = "examples_checked_in_requirements_bzl__google_api_core_0_1_4",
    runtime_deps = ["futures", "googleapis-common-protos", "protobuf", "six", "pytz", "setuptools", "requests", "google-auth"],
  )

  whl_library(
    requirement = "google-auth==1.4.1",
    name = "examples_checked_in_requirements_bzl__google_auth_1_4_1",
    runtime_deps = ["six", "pyasn1-modules", "cachetools", "rsa"],
  )

  whl_library(
    requirement = "google-cloud==0.29.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_0_29_0",
    runtime_deps = ["google-cloud-pubsub", "google-cloud-resource-manager", "google-cloud-firestore", "google-cloud-bigtable", "google-cloud-spanner", "google-cloud-storage", "google-cloud-videointelligence", "google-cloud-language", "google-api-core", "google-cloud-core", "google-cloud-error-reporting", "google-cloud-speech", "google-cloud-vision", "google-cloud-monitoring", "google-cloud-runtimeconfig", "google-cloud-logging", "google-cloud-trace", "google-cloud-datastore", "google-cloud-translate", "google-cloud-bigquery", "google-cloud-dns"],
  )

  whl_library(
    requirement = "google-cloud-bigquery==0.28.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_bigquery_0_28_0",
    runtime_deps = ["requests", "google-resumable-media", "google-api-core", "google-cloud-core", "google-auth"],
  )

  whl_library(
    requirement = "google-cloud-bigtable==0.28.1",
    name = "examples_checked_in_requirements_bzl__google_cloud_bigtable_0_28_1",
    runtime_deps = ["google-gax", "google-api-core", "google-cloud-core"],
  )

  whl_library(
    requirement = "google-cloud-core==0.28.1",
    extras = ["grpc"],
    name = "examples_checked_in_requirements_bzl__google_cloud_core_0_28_1",
    runtime_deps = ["google-api-core"],
  )

  whl_library(
    requirement = "google-cloud-datastore==1.4.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_datastore_1_4_0",
    runtime_deps = ["google-gax", "gapic-google-cloud-datastore-v1", "google-cloud-core", "google-api-core"],
  )

  whl_library(
    requirement = "google-cloud-dns==0.28.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_dns_0_28_0",
    runtime_deps = ["google-api-core", "google-cloud-core"],
  )

  whl_library(
    requirement = "google-cloud-error-reporting==0.28.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_error_reporting_0_28_0",
    runtime_deps = ["gapic-google-cloud-error-reporting-v1beta1", "google-api-core", "google-cloud-core", "google-cloud-logging"],
  )

  whl_library(
    requirement = "google-cloud-firestore==0.28.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_firestore_0_28_0",
    runtime_deps = ["google-gax", "google-api-core", "google-cloud-core"],
  )

  whl_library(
    requirement = "google-cloud-language==0.31.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_language_0_31_0",
    runtime_deps = ["enum34", "google-api-core[grpc]", "google-auth"],
  )

  whl_library(
    requirement = "google-cloud-logging==1.4.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_logging_1_4_0",
    runtime_deps = ["google-cloud-core[grpc]", "gapic-google-cloud-logging-v2", "google-api-core"],
  )

  whl_library(
    requirement = "google-cloud-monitoring==0.28.1",
    name = "examples_checked_in_requirements_bzl__google_cloud_monitoring_0_28_1",
    runtime_deps = ["google-api-core", "google-cloud-core"],
  )

  whl_library(
    requirement = "google-cloud-pubsub==0.29.4",
    name = "examples_checked_in_requirements_bzl__google_cloud_pubsub_0_29_4",
    runtime_deps = ["grpc-google-iam-v1", "psutil", "google-api-core[grpc]", "google-auth"],
  )

  whl_library(
    requirement = "google-cloud-resource-manager==0.28.1",
    name = "examples_checked_in_requirements_bzl__google_cloud_resource_manager_0_28_1",
    runtime_deps = ["google-api-core", "google-cloud-core"],
  )

  whl_library(
    requirement = "google-cloud-runtimeconfig==0.28.1",
    name = "examples_checked_in_requirements_bzl__google_cloud_runtimeconfig_0_28_1",
    runtime_deps = ["google-api-core", "google-cloud-core"],
  )

  whl_library(
    requirement = "google-cloud-spanner==0.29.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_spanner_0_29_0",
    runtime_deps = ["google-api-core", "grpc-google-iam-v1", "google-gax", "google-cloud-core[grpc]", "requests", "google-auth"],
  )

  whl_library(
    requirement = "google-cloud-speech==0.30.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_speech_0_30_0",
    runtime_deps = ["google-cloud-core[grpc]", "google-gax", "google-api-core"],
  )

  whl_library(
    requirement = "google-cloud-storage==1.6.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_storage_1_6_0",
    runtime_deps = ["requests", "google-resumable-media", "google-api-core", "google-cloud-core", "google-auth"],
  )

  whl_library(
    requirement = "google-cloud-trace==0.16.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_trace_0_16_0",
    runtime_deps = ["google-cloud-core[grpc]", "google-gax", "google-api-core"],
  )

  whl_library(
    requirement = "google-cloud-translate==1.3.1",
    name = "examples_checked_in_requirements_bzl__google_cloud_translate_1_3_1",
    runtime_deps = ["google-api-core", "google-cloud-core"],
  )

  whl_library(
    requirement = "google-cloud-videointelligence==0.28.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_videointelligence_0_28_0",
    runtime_deps = ["googleapis-common-protos", "six", "google-gax", "grpcio"],
  )

  whl_library(
    requirement = "google-cloud-vision==0.28.0",
    name = "examples_checked_in_requirements_bzl__google_cloud_vision_0_28_0",
    runtime_deps = ["google-cloud-core[grpc]", "enum34", "google-gax", "google-api-core"],
  )

  whl_library(
    requirement = "google-gax==0.15.16",
    name = "examples_checked_in_requirements_bzl__google_gax_0_15_16",
    runtime_deps = ["dill", "googleapis-common-protos", "protobuf", "ply", "future", "grpcio", "requests", "google-auth"],
  )

  whl_library(
    requirement = "google-resumable-media==0.3.1",
    extras = ["requests"],
    name = "examples_checked_in_requirements_bzl__google_resumable_media_0_3_1",
    runtime_deps = ["six"],
  )

  whl_library(
    requirement = "googleapis-common-protos==1.5.3",
    extras = ["grpc"],
    name = "examples_checked_in_requirements_bzl__googleapis_common_protos_1_5_3",
    runtime_deps = ["protobuf"],
  )

  whl_library(
    requirement = "grpc-google-iam-v1==0.11.4",
    name = "examples_checked_in_requirements_bzl__grpc_google_iam_v1_0_11_4",
    runtime_deps = ["grpcio", "googleapis-common-protos[grpc]"],
  )

  whl_library(
    requirement = "grpcio==1.11.0",
    name = "examples_checked_in_requirements_bzl__grpcio_1_11_0",
    runtime_deps = ["enum34", "six", "futures", "protobuf"],
  )

  whl_library(
    requirement = "httplib2==0.11.3",
    name = "examples_checked_in_requirements_bzl__httplib2_0_11_3",
  )

  whl_library(
    requirement = "idna==2.6",
    name = "examples_checked_in_requirements_bzl__idna_2_6",
  )

  whl_library(
    requirement = "jmespath==0.9.3",
    name = "examples_checked_in_requirements_bzl__jmespath_0_9_3",
  )

  whl_library(
    requirement = "numpy==1.14.2",
    name = "examples_checked_in_requirements_bzl__numpy_1_14_2",
  )

  whl_library(
    requirement = "oauth2client==3.0.0",
    name = "examples_checked_in_requirements_bzl__oauth2client_3_0_0",
    runtime_deps = ["pyasn1-modules", "six", "pyasn1", "httplib2", "rsa"],
  )

  whl_library(
    requirement = "pip==9.0.0",
    name = "examples_checked_in_requirements_bzl__pip_9_0_0",
  )

  whl_library(
    requirement = "ply==3.8",
    name = "examples_checked_in_requirements_bzl__ply_3_8",
  )

  whl_library(
    requirement = "proto-google-cloud-datastore-v1==0.90.4",
    extras = ["grpc"],
    name = "examples_checked_in_requirements_bzl__proto_google_cloud_datastore_v1_0_90_4",
    runtime_deps = ["oauth2client", "googleapis-common-protos"],
  )

  whl_library(
    requirement = "proto-google-cloud-error-reporting-v1beta1==0.15.3",
    extras = ["grpc"],
    name = "examples_checked_in_requirements_bzl__proto_google_cloud_error_reporting_v1beta1_0_15_3",
    runtime_deps = ["oauth2client", "googleapis-common-protos"],
  )

  whl_library(
    requirement = "proto-google-cloud-logging-v2==0.91.3",
    extras = ["grpc"],
    name = "examples_checked_in_requirements_bzl__proto_google_cloud_logging_v2_0_91_3",
    runtime_deps = ["oauth2client", "googleapis-common-protos"],
  )

  whl_library(
    requirement = "protobuf==3.5.2.post1",
    name = "examples_checked_in_requirements_bzl__protobuf_3_5_2_post1",
    runtime_deps = ["six", "setuptools"],
  )

  whl_library(
    requirement = "psutil==5.4.5",
    extras = ["enum"],
    name = "examples_checked_in_requirements_bzl__psutil_5_4_5",
  )

  whl_library(
    requirement = "pyasn1==0.4.2",
    name = "examples_checked_in_requirements_bzl__pyasn1_0_4_2",
  )

  whl_library(
    requirement = "pyasn1-modules==0.2.1",
    name = "examples_checked_in_requirements_bzl__pyasn1_modules_0_2_1",
    runtime_deps = ["pyasn1"],
  )

  whl_library(
    requirement = "python-dateutil==2.6.1",
    name = "examples_checked_in_requirements_bzl__python_dateutil_2_6_1",
    runtime_deps = ["six"],
  )

  whl_library(
    requirement = "pytz==2018.4",
    name = "examples_checked_in_requirements_bzl__pytz_2018_4",
  )

  whl_library(
    requirement = "requests==2.18.4",
    name = "examples_checked_in_requirements_bzl__requests_2_18_4",
    runtime_deps = ["idna", "certifi", "chardet", "urllib3"],
  )

  whl_library(
    requirement = "rsa==3.4.2",
    name = "examples_checked_in_requirements_bzl__rsa_3_4_2",
    runtime_deps = ["pyasn1"],
  )

  whl_library(
    requirement = "scikit-learn==0.17.1",
    name = "examples_checked_in_requirements_bzl__scikit_learn_0_17_1",
  )

  whl_library(
    requirement = "scipy==0.17.1",
    name = "examples_checked_in_requirements_bzl__scipy_0_17_1",
  )

  whl_library(
    requirement = "setuptools==39.0.1",
    extras = ["certs", "ssl"],
    name = "examples_checked_in_requirements_bzl__setuptools_39_0_1",
  )

  whl_library(
    requirement = "six==1.11.0",
    name = "examples_checked_in_requirements_bzl__six_1_11_0",
  )

  whl_library(
    requirement = "urllib3==1.22",
    name = "examples_checked_in_requirements_bzl__urllib3_1_22",
  )


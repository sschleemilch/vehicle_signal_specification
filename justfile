VSS_VERSION := env_var_or_default("VSS_VERSION", "0.0")
COMMON_ARGS := "-u ./spec/units.yaml --strict"
COMMON_VSPEC_ARG := "-s ./spec/VehicleSignalSpecification.vspec"
COMMON_DATATYPES_ARG := "-t ./spec/VehicleDataTypes.vspec"

default: clean apigear avro binary compose csv datatypes ddsidl go id json json-noexpand jsonschema plantuml samm s2dm yaml protobuf overlays

datatypes:
    vspec export json {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} {{COMMON_DATATYPES_ARG}} -o vss_with_datatypes.json

apigear:
    vspec export apigear {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} --output-dir apigear
    cd apigear && tar -czvf ../vss_apigear.tar.gz * && cd ..

avro:
    vspec export avro {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} {{COMMON_DATATYPES_ARG}} -o avro --namespace xxx

binary:
    vspec export binary {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o vss.binary

compose:
    vspec compose --vspec spec/VehicleSignalSpecification.vspec --units spec/units.yaml --quantities spec/quantities.yaml -o compose
    cd compose && tar -czvf ../vss_compose.tar.gz * && cd ..

csv:
    vspec export csv {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o vss.csv

ddsidl:
    vspec export ddsidl {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o vss.idl

go:
    vspec export go {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o vss.go

id:
    vspec export id {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o vss.vspec

json:
    vspec export json {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o vss.json

json-noexpand:
    vspec export json {{COMMON_ARGS}} --no-expand {{COMMON_VSPEC_ARG}} -o vss_noexpand.json

jsonschema:
    vspec export jsonschema {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o vss.jsonschema

plantuml:
    vspec export plantuml {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o vss.puml

protobuf:
    vspec export protobuf {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o vss.proto

samm:
    vspec export samm {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} --target-folder samm
    cd samm && tar -czvf ../vss_samm.tar.gz * && cd ..

s2dm:
    vspec export s2dm {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o graphql
    cd graphql && tar -czvf ../vss_graphql.tar.gz * && cd ..

yaml:
    vspec export yaml {{COMMON_ARGS}} {{COMMON_VSPEC_ARG}} -o vss.yaml

overlays:
    vspec export json {{COMMON_ARGS}} -l overlays/profiles/motorbike.vspec {{COMMON_VSPEC_ARG}} -o vss_motorbike.json
    vspec export json {{COMMON_ARGS}} -l overlays/extensions/dual_wiper_systems.vspec {{COMMON_VSPEC_ARG}} -o vss_dualwiper.json
    vspec export json {{COMMON_ARGS}} -l overlays/extensions/OBD.vspec {{COMMON_VSPEC_ARG}} -o vss_obd.json

docs:
    hugo -s ./docs-gen

clean:
    rm -f vss.*
    rm -f vss_*
    rm -rf apigear
    rm -rf compose
    rm -rf samm
    rm -rf graphql
    rm -rf avro

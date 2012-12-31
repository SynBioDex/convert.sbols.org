xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/BBa_T9002.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid01_missing_displayId.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid02_no_rdf_root.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid03_bad_ordering.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid04_bad_nucleotide_char.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid05_empty_nucleotides.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid06_missing_nucleotides.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid07_negative_bioStart.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid08_bioStart_exists_bioEnd_missing.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid09_multiple_bioStart.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid10_bad_strand.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid11_standalone_sequence_annotation.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid12_subComponent_missing.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/invalid13_type_not_so.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/valid10.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/valid1.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/valid2.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/valid3.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/valid4.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/valid5.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/valid6.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/valid7.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/valid8.xml 2>> evren_test_result
xmllint --schema schema/sbol.xsd --schema schema/rdf.xsd examples/valid9.xml 2>> evren_test_result
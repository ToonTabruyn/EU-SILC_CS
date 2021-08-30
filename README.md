# Open Family Policy Program (EU-SILC_CS)

The Program translates national family policy legislations into a Stata code. In combination with survey data (EU-SILC CS in this case), the Program creates a collection of policy variables that indicate which respondents would be entitled to family policies, the duration of the benefit payments and the amount of benefits. For more information about the Program see _Methodology_report_eusilc_cs_ file in this Repository. 

[![DOI](https://zenodo.org/badge/399796332.svg)](https://zenodo.org/badge/latestdoi/399796332)

# To run the Program:
1. merge the original EU-SILC CS files using _SD_merge_eusilc_cs.do_ 
    - skip this step if you already have a merged EU-SILC file
3. add your DATA directory in _MAIN_eusilc_cs.do_
4. add your CODE directory in _MAIN_eusilc_cs.do_
5. if you already have your merged EU-SILC file, add the name of the data file in _MAIN_eusilc_cs.do_
6. run _MAIN_eusilc_cs.do_


# License 

The Open Family Policy Program is licensed under the GNU GPL3 license. For details on the condition of the license see the document LICENSE in this repository.


# Funding 

This project has received funding from the European Union’s Horizon 2020 research and innovation programme under grant agreement No 893008.


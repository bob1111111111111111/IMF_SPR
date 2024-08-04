* Q3
* load the necessary packages
clear all
set more off

* Import GDP data
import excel "/Users/wangboyuan/Desktop/Stata Test 8.2/TakeHomeAssignment_Hybrid/test_excel.xlsx", sheet("GDP") firstrow

* Merge datasets & Replace missing value
merge 1:1 _n using "/Users/wangboyuan/Desktop/Stata Test 8.2/TakeHomeAssignment_Hybrid/oil_exporters.dta", nogen

replace oil_exporters = 0 if missing(oil_exporters)

* Q4
* Generate a variable called "NGDP_RPCH_A_max"
bysort country: egen NGDP_RPCH_A_max = max(NGDP_RPCH_A)

* Collapse the dataset by year and oil_exporters
collapse (mean) NGDP_RPCH_A, by(year oil_exporters)

* Reshape the dataset to wide
reshape wide NGDP_RPCH_A, i(oil_exporters) j(year)

* Q5
* Save files
save "/Users/wangboyuan/Desktop/Stata Test 8.2/TakeHomeAssignment_Hybrid/dataset_Boyuan Wang.dta", replace

export excel using "/Users/wangboyuan/Desktop/Stata Test 8.2/TakeHomeAssignment_Hybrid/dataset_Boyuan Wang.xlsx", sheet("data") firstrow(variables),replace

data:
	mkdir -p data

results:
	mkdir -p results

load:
	Rscript R/01_load_data.R

method:
	Rscript R/02_methods.R

model:
	Rscript R/03_model.R

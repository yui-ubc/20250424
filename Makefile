all:
	mkdir -p data
	mkdir -p results
	Rscript R/01_load_data.R
	Rscript R/02_methods.R
	Rscript R/03_model.R
	Rscript R/04_results.R

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

output:
	Rscript R/04_results.R

clean:
	rm -rf data
	rm -rf results

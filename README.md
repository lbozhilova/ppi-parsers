# PPI data parsers

## BioGRID

The `parse_biogrid()` function in `biogrid-parser.R` is intended for parsing species-specific tab3 files from the BioGRID database. You can find the BioGRID release archive [here](https://downloads.thebiogrid.org/BioGRID/Release-Archive) where you can download the data.

Once you have downloaded and unzipped the data in a folder `/data/` within your working directory, an example call might be:
```
fn <- "data/BIOGRID-ORGANISM-Saccharomyces_cerevisiae_S288c-4.3.195.tab3.txt"
df <- parse_biogrid(fn, 
                    interspecies = FALSE,
                    loops = FALSE,
                    experimental_system = NULL,
                    experimental_system_type = "physical",
                    throughput = NULL)
```
This will return a dataframe of interaction records for yeast (_S. cerevisiae_). Interactions will be between proteins of yeast only, without
any cross-species interactions (`interspecies = FALSE`). Homodimeric interactions, i.e. interactions between two copies of the same protein, will not be included (`loops = FALSE`). The interactions will not be filtered by experimental system (`experimental_system = NULL`) but only physical interactions will be reported, and not genetic interactions (`experimental_system_type = "physical"`). Interactions from low-, medium-, and high-throughput experiments will all be reported (`throughput = NULL`).

At some point I hope to edit the output format of the parser and to include extensive examples and explanations. In the meanttime you will need to adapt the code to your needs. 

# 🍝 College Food Insecurity
How much food insecurity exists among U.S. college students? I answer this question 
using the 2025 Annual Social and Economic Supplement to the Current Population Survey
and the December 2023 wave of the Current Population Survey, accessed through IPUMS, along with 
my demographR package.

## 📊 Key Findings

According to the 2025 ASEC, 9.8% of full-time college students over age 18 were on food stamps, while
9.0% of part-time college students were on food stamps.

According to the ASEC data, about 76% of respondents reported having enough of the 
kinds of food they wanted to eat. Of the remaining one quarter students, roughly
4 in 5 reports having enough food, but not the kinds they want to eat, and 1 in 5 reports
sometimes or always not having enough to eat.

| FSFOODS Code | Food Sufficiency Description                                | Weighted Count | Unweighted Count | Percent |
|:-------------:|:------------------------------------------------------------|----------------:|-----------------:|-------------:|
| 1             | Enough of the kinds of food we want to eat                  | 9,181,939       | 2,296            | 75.5 %        |
| 2             | Enough but not always the kinds of food we want to eat      | 2,538,402       |   646            | 20.9 %        |
| 3             | Sometimes not enough to eat                                |   367,948       |    85            | 3.0 %        |
| 4             | Often not enough to eat                                    |    58,165       |    14            | 0.5 %        |
| 97            | Don’t know                                                 |    12,977       |     4            | 0.1 %         |

According to [this definition](https://cps.ipums.org/cps-action/variables/FSSTATUSD#description_section), roughly 22% of college students suffer from some form of food insecurity.

| FSSTATUSD Code | USDA Food Security Category     | Weighted Count | Unweighted Count | Percent |
|:---------------:|:-------------------------------|----------------:|-----------------:|-------------:|
| 1 | High food security | 9,428,621 | 2,375 | 77.5 % |
| 2 | Marginal food security | 1,197,125 | 305 | 9.9 % |
| 3 | Low food security | 1,016,788 | 247 | 8.4 % |
| 4 | Very low food security | 491,536 | 112 | 4.0 % |
| 98 | No response | 25,362 | 6 | 0.2 % |


Percentage of students in higher education with less than $30,000 income per year and no kitchen facilities:

Percentage of students in higher education who have used a food bank in the last month:


## ⚡ Quick Start
For experienced users who just want to get the project running right away. If you
have trouble following these steps, please follow the **Detailed Start** guide below.

1. Navigate to the directory where you want the repo

    ```bash
    cd your/path/to/parent/directory
    ```

2. Clone both required repos side by side

    ```bash
    git clone https://github.com/lorae/college-food-insecurity college-food-insecurity
    git clone https://github.com/lorae/demographr demographr
    ```

3. Enter the main project

    ```bash
    cd college-food-insecurity
    ```

4. Copy the environment file and edit it with your own [IPUMS API key](https://account.ipums.org/api_keys)

    ```bash
    cp example.Renviron .Renviron
    # (Windows PowerShell: Copy-Item example.Renviron .Renviron)
    # IMPORTANT: open .Renviron and replace "your_ipums_api_key" with your actual key
    ```

5. Restore dependencies and run the analysis

    Open `college-food-insecurity.Rproj` in your preferred IDE, then in the R console:
    
    ```r
    renv::restore()
    source("run-all.R")
    ```
    


## 📎 Detailed Start
Detailed instructions for how to fully install and run this project code on your computer.

###  Part A: Clone the repo and configure the R project

These steps will allow you to install the code on your computer that runs this project and set up the environment so that it mimics the environment on which the code was developed.

1. **Clone the repo**: Open a terminal on your computer. Navigate to the directory you would like to be the parent directory of the repo, then clone the repo.

    MacOS/Linux:
    
    ```bash
    cd your/path/to/parent/directory
    ```
    ```bash
    git clone https://github.com/lorae/college-food-insecurity college-food-insecurity
    ```
    
    Windows:
    
    ```cmd
    cd your\path\to\parent\directory
    ```
    ```cmd
    git clone https://github.com/lorae/college-food-insecurity college-food-insecurity
    ```

2. **Open the R project**: Navigate into the directory, now located at `your/path/to/parent/directory/college-food-insecurity`.
Open `college-food-insecurity.Rproj` using your preferred IDE for R. (We use R Studio.)

    Every subsequent time you work with the project code, you should always open the `college-food-insecurity.Rproj` file
    at the beginning of your work session. This will avoid common issues with broken file paths or an incorrect working directory.

3. **Initialize R environment**: Install all the dependencies (packages) needed to make the code run on your computer.

    First, ensure you have the package manager, `renv`, installed. Run the following in your R console:
    
    ```r
    install.packages("renv") # Safe to run, even if you're not sure if you already have renv
    ```
    ```r
    library("renv")
    ```
    
    Then restore the project:
    
    ```r
    renv::restore()
    ```

4. **Clone the sibling repo, `demographr`**: This project makes use of a bundle of functions that are unit-tested
and generalized in a package called `demographr`. Clone this repo in the same parent directory where you cloned 
`immigrant-households`.

    🛑 Important: Do not clone this **inside** of the `immigrant-households` repo: instead, it should be a 
    sibling: it should contained in the same folder structure as `college-food-insecurity`.

    MacOS/Linux:
    
    ```bash
    cd your/path/to/parent/directory
    ```
    ```bash
    git clone https://github.com/lorae/demographr demographr
    ```
    
    Windows:
    
    ```cmd
    cd your\path\to\parent\directory
    ```
    ```cmd
    git clone https://github.com/lorae/demographr demographr
    ```
    
###  Part B: Configure API Access

The [IPUMS Terms of Use](https://www.ipums.org/about/terms) precludes us from directly sharing the raw microdata extract, however,
the data used in this analysis is freely available after setting up an IPUMS USA account, and we provide an automated script that 
writes the API call and downloads the exact data used in this analysis. 

5. **Copy the file** `example.Renviron` to a new file named `.Renviron` in the project root directory. 
You can do this manually or use the following terminal commands:

    MacOS/Linux:
    
    ```bash
    cp example.Renviron .Renviron
    ```
    
    Windows (use PowerShell):
    
    ```ps1
    Copy-Item example.Renviron .Renviron
    ```
    
6. **Set up your IPUMS USA API key**: If you don't already have one, set up a free account on 
[IPUMS USA](https://uma.pop.umn.edu/usa/user/new). Use the new account to login to the 
[IPUMS API key](https://account.ipums.org/api_keys) webpage. Copy your API key from this webpage.

7. **Open `.Renviron`** (‼️**not** `example.Renviron`!) and replace `your_ipums_api_key` with your actual key.  Do not include quotation marks. 
R will automatically load `.Renviron` when you start a new session. This keeps your API key private and separate 
from the codebase.

    🛑 Important: `.Renviron` is listed in `.gitignore`, so it will not be tracked or uploaded to GitHub — but `example.Renviron` is tracked, so do not put your actual API key in the example file.

### Part C: Run the analysis scripts

The code for this project is stored in the `src` folder:

- `scripts/`: executable analysis scripts

- `utils/`: accessory modules (functions), subject to unit tests

8. Run all code by sourcing the `run-all.R` script in your R console:

    ```r
    source("run-all.R")
    ```
    


## 📜 License
MIT License (see LICENSE file).

## 📚 Citation
This repository accompanies ongoing research on college food insecurity. 

For now, please cite as:  
*College Food Insecurity: Replication Code and Analysis*. Lorae Stojanovic.  
GitHub. https://github.com/lorae/college-food-insecurity

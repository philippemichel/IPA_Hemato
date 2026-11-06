#  ------------------------------------------------------------------------
#
# Title : Import HDJ-TO-Hemato
#    By : PhM
#  Date : 2026-02-23
#
#  ------------------------------------------------------------------------
library(tidyverse)
library(labelled)
library(readODS)
library(baseph)

#
#   Professionnels de santé
#
pros <- read_ods("data/hdj_hemato.ods", sheet = "professionnels") |>
  janitor::clean_names() |>
  mutate(across(where(is.character), as.factor)) |>
  mutate(profession = fct_relevel(
    profession,
    "Médecin", "IDE", "Aide-soignant(e)", "Cadre de santé", "Autre"
  )) |>
  mutate(type_etablissement = fct_relevel(
    type_etablissement,
    "Centre hospitalier universitaire (CHU)",
    "Centre hospitalier (CH)",
    "Clinique privée",
    "Autre"
  )) |>
  mutate(anciennete = fct_relevel(
    anciennete,
    "Moins de 2 ans",
    "2-5 ans",
    "6-10 ans",
    "Plus de 10 ans"
  ))

bn <- read_ods("data/hdj_hemato.ods", sheet = "bnom_pros")
var_label(pros) <- bn$nom

#
#  Save
#
save(pros, file = "data/hdj_hemato.RData")
load("data/hdj_hemato.RData")

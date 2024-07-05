const fetch = require("node-fetch");

const apiKey = "5ln/cNSd7OW/bNvLui5+WIC0ljQ4gb/1irOPdeodJQUbo02+zv/mlp/rYLTbwBka";

const requestOptions = {
  method: "GET",
  headers: {
    Authorization: `Bearer ${apiKey}`,
  },
};

function recruitsByYear(year, team) {
  fetch(
    `https://api.collegefootballdata.com/recruiting/players?year=${year}&classification=HighSchool&team=${team}`,
    requestOptions
  )
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then((data) => {
      console.log(data);
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}

const allRecruits =
  recruitsByYear(2021, "Alabama") |
  recruitsByYear(2020, "Alabama") |
  recruitsByYear(2019, "Alabama") |
  recruitsByYear(2018, "Alabama") |
  recruitsByYear(2017, "Alabama");

function draftClasses(year) {
  fetch(`https://api.collegefootballdata.com/draft/picks?year=${year}`, requestOptions)
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then((data) => {
      console.log(data);
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}

const allDraftClasses =
  draftClasses(2024) | draftClasses(2023) | draftClasses(2022) | draftClasses(2021) | draftClasses(2020);

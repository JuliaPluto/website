window.observablehq.Library();

// Refactoring this due to https://caniuse.com/?search=top%20level%20await (top level await not implemented in Safari, Firefox, Chrome - 2)
async function init() {
  const html = window.observablehq.html();
  const md = await window.observablehq.md();
  const d3 = window.d3;

  const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;

  const sheet_url =
    "https://docs.google.com/spreadsheets/d/e/2PACX-1vTvZQ9CTT9xnqoS6H37zqGlIpONNJmUmUwTCwwWCR8icNCMxWXnNwSC975zO6Cr_LgM78JNOa6MMp-O/pub?gid=1151726587&single=true&output=csv";

  const csv_data_raw = await (await fetch(sheet_url, {
    cache: "no-cache"
  })).text();

  const csv_data = d3.csvParse(csv_data_raw);
  console.log(csv_data);

  function show_main(obj) {
    const main = document.querySelector("main");
    main.innerHTML = "";
    main.appendChild(obj);
  }

  const isonthursday = row => row.From.includes("Thu");
  const isonfriday = row => row.From.includes("Fri");

  const localTime = time =>
    window
      .moment(`2021-04-08T${time.match(/.*, (.*)/)[1]}+02:00`)
      .local()
      .format()
      .slice(11, 16);

  const card = row => {
    const {
      From,
      BufferEnd,
      Speaker,
      SpeakerLink,
      Title,
      Category,
      YoutubeLink,
      NotebookLink,
      Abstract
    } = row;

    const abstract_node = md([Abstract]);
    abstract_node.classList.add("card-text");
    return html`
      <div class="card ${Category}">
        <div class="card-body">
          <span class="time">${localTime(From)} - ${localTime(BufferEnd)}</span>
          <h5 class="card-title">
            <a class="subtle-link" href=${YoutubeLink}>${Title}</a>
          </h5>
          <h6 class="card-subtitle mb-2 text-muted">
            <a class="subtle-link" href=${SpeakerLink}>${Speaker}</a>
          </h6>

          ${abstract_node}
          ${YoutubeLink === ""
            ? html``
            : html`
                <a href=${YoutubeLink} class="card-link">Youtube</a>
              `}
          ${NotebookLink === ""
            ? html``
            : html`
                <a href=${NotebookLink} class="card-link">Notebook</a>
              `}
        </div>
      </div>
    `;
  };

  function legend() {
    const opts = [
      ".card.Announcements",
      ".card.PlutoDevelopment",
      ".card.Art",
      ".card.Education",
      ".card.Science",
      ".card.Tools"
    ];

    return html`
      <div class="legend">
        ${opts.map(
          the_class =>
            html`
              <div class="${the_class.replace(/\./g, " ")}">
                ${the_class.match(/\..*\.(.*)/)[1]}
              </div>
            `
        )}
      </div>
    `;
  }

  function render_page(data) {
    show_main(
      html`
        <p>
          All times are shown in your local time zone
          <em>${new Date().toString().match(/(\((.*)\))/)[0]}</em>.
        </p>

        <h2>Thursday, April 8th 2021</h2>
        ${data.filter(isonthursday).map(card)}
        <br />
        <h2>Friday, April 9th 2021</h2>
        ${data.filter(isonfriday).map(card)}
        <br />
        ${legend()}
      `
    );
  }
  render_page(csv_data);
  window.data = csv_data;
}

init();

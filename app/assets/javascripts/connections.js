class Connection {
  constructor(args) {
    this.id = args.id;
    this.motimate_id = args.motimate_id;
    this.user_id = args.user_id;
  }

  static setAddButtons() {
    const acceptLinks = document.querySelectorAll(".js-accept");
    for (const link of acceptLinks) {
      Connection.createListener(link);
    }
  }

  static createListener(link) {
    link.addEventListener("click", function (e) {
      const el = e.path[3];
      const data = this.dataset;
      Connection.accept(data, el).then(json => {
        if (!Connection.isRequestPresent()) {
          Connection.renderEmptyMessage();
        }
        Connection.updateMotimateList(json);
      });
    });
  }

  static async accept(data, el) {
    const userId = data.userId;
    const motimateId = data.motimateId;
    try {
      const token = document.querySelector('meta[name="csrf-token"]').content;
      const resp = await fetch(
        `/motimates?user_id=${userId}&motimate_id=${motimateId}`, {
          method: "POST",
          headers: {
            Accept: "application/json",
            "X-CSRF-Token": token
          },
          credentials: "same-origin"
        }
      );
      if (resp.ok) {
        el.nextElementSibling.remove();
        el.remove();
        const json = await resp.json();
        return json;
      }
    } catch (e) {
      console.log("There was an error with accepting the motimate request", e);
    }
  }

  static isRequestPresent() {
    return (
      document.querySelector(".ui.comments .request.comment.item") !== null
    );
  }

  static renderEmptyMessage() {
    const icon = document.getElementById("request-icon");
    icon.remove();
    const div = document.createElement("div");
    div.classList += "comment item";
    const text = document.createElement("div");
    text.classList.add("text");
    text.textContent = "You have no motimate requests.";
    div.appendChild(text);
    document.querySelector(".ui.comments").appendChild(div);
  }

  static updateMotimateList(userJson) {
    const motimateList = document.getElementById("user-motimates");
    console.log(userJson);
    if (motimateList !== null) {
      const ul = motimateList.firstElementChild;
      const li = document.createElement("li");
      // TODO: build out li with user data

    }
  }
}
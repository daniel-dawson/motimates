class Connection {
  constructor(json) {
    const rels = json.included;
    const data = json.data;
    for (const rel of rels) {
      if (rel.type === "motimate") {
        this.motimate = rel;
      } else {
        this.user = rel;
      }
    }

    this.id = data.id;
    this.note = data.attributes.note;
    this.acceptedAt = data.attributes.acceptedAt;
    this.connectionStart = moment(this.acceptedAt).fromNow();
  }

  static setAddButtons() {
    const acceptLinks = document.querySelectorAll(".js-accept");
    for (const link of acceptLinks) {
      Connection.createListener(link);
    }
  }

  static createListener(link) {
    link.addEventListener("click", function(e) {
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
        `/motimates?user_id=${userId}&motimate_id=${motimateId}`,
        {
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
    const connection = new Connection(userJson);
    const motimateList = document.getElementById("user-motimates");

    // motimateList will be null if it does not belong to
    // the current user
    if (motimateList !== null) {
      const ul = motimateList.firstElementChild;
      const li = document.createElement("div");
      li.classList.add("item");
      const img = document.createElement("img");
      img.setAttribute("height", 60);
      img.setAttribute("width", 60);
      const avatar_url =
        connection.motimate.attributes.avatarUrl === null
          ? connection.motimate.attributes.defaultAvatarUrl
          : connection.motimate.attributes.avatarUrl;
      img.setAttribute("src", avatar_url);
      img.classList.add("ui", "middle", "aligned", "rounded", "image");

      const contentDiv = document.createElement("div");
      contentDiv.classList.add("middle", "aligned", "content");

      const header = document.createElement("a");
      header.classList.add("header");
      header.href = connection.motimate.links.profilUrl;
      header.textContent = connection.motimate.attributes.name;

      const description = document.createElement("div");
      description.classList.add("description");
      description.textContent = `motimates since ${connection.connectionStart}`;

      contentDiv.append(header, description);

      li.append(img, contentDiv);
      ul.appendChild(li);
    }
  }
}

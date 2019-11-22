class Profile {
  static renderMotimates(list) {
    const userId = list.dataset.id;
    this.getMotimatesFor(userId).then(json => {
      const motimateList = this.buildList(json);
      list.append(motimateList);
    });
  }

  static async getMotimatesFor(userId) {
    try {
      const response = await fetch(
        `http://localhost:3000/users/${userId}/motimates`
      );
      const json = await response.json();
      return json;
    } catch (error) {
      console.log(error);
    }
  }

  static buildList(json) {
    const motimates = json.data;
    const list = document.createElement("div");
    list.classList.add("ui", "relaxed", "list");

    for (const moti of motimates) {
      const attrs = moti.attributes;

      const item = document.createElement("div");
      item.classList.add("item");

      const avatar = document.createElement("img");
      avatar.classList.add("ui", "middle", "aligned", "rounded", "image");
      const avatarUrl =
        attrs.avatarUrl === null ? attrs.defaultAvatarUrl : attrs.avatarUrl;
      avatar.setAttribute("src", avatarUrl);
      avatar.setAttribute("height", 60);
      avatar.setAttribute("width", 60);

      const content = document.createElement("div");
      content.classList.add("middle", "aligned", "content");

      const header = document.createElement("a");
      header.classList.add("header");
      header.textContent = attrs.name;
      header.href = moti.links.profileUrl;

      const description = document.createElement("div");
      description.classList.add("description");
      description.textContent = `motimates since ${moment(
        attrs.acceptedAt
      ).fromNow()}`;
      content.append(header, description);

      item.append(avatar, content);
      list.append(item);
    }
    return list;
  }
}

document.addEventListener("turbolinks:load", () => {
  const motimateList = document.querySelector("div[id$='motimates']");
  if (motimateList != null) {
    Profile.renderMotimates(motimateList);
  }
});

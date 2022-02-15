var Actions = {
  linkActionClasses: [".actions-disable", ".actions-activate"],

  bindLinkActionEvent: function () {
    this.linkActionClasses.forEach((linkActionClass) => {
      document.querySelectorAll(linkActionClass).forEach((element) => {
        element.addEventListener("click", (event) => {
          event.preventDefault();
          this.handleLinkEvent(element);
        });
      });
    });
  },

  handleLinkEvent: function (element) {
    let { linkKey, linkStatus } = element.dataset;
    const csrf_token = document.querySelector("meta[name=csrf-token]").content;
    const csrf_param = document.querySelector("meta[name=csrf-param]").content;
    const data = {
      id: linkKey,
      status: linkStatus,
      [csrf_param]: csrf_token,
    };

    fetch("links/update_status", {
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "Content-Type": "application/json",
      },
      method: "PUT",
      body: JSON.stringify(data),
    })
      .then((response) => response.json())
      .then((data) => {
        this.handleSuccessEvent(data, element);
      })
      .catch((error) => {
        this.handleErrorEvent(error, element);
      });
  },

  handleSuccessEvent: function (data, element) {
    element.dataset.linkStatus = this.getButtonStatusAfterClick(element);
    element.className = this.getButtonClassName(element);
    element.innerText = this.getButtonTextAfterClick(element);
    element.parentNode.parentNode.className = this.getRowClassName(element);
  },

  handleErrorEvent: function (error, element) {
    console.log(error);
  },

  getButtonTextAfterClick: function (element) {
    var text = isActiveElement(element) ? "Disable" : "Activate";
    return text;
  },

  getButtonClassName: function (element) {
    var className = isActiveElement(element)
      ? "actions-disable"
      : "actions-activate";
    return className;
  },

  getRowClassName: function (element) {
    var className = isActiveElement(element) ? "row-invalid" : "row";
    return className;
  },

  getButtonStatusAfterClick: function (element) {
    var status = element.dataset.linkStatus === "true" ? false : true;
    return status;
  },

  isActiveElement: function (element) {
    return element.innerText === "Activate";
  },
};

window.onload = (event) => {
  Actions.bindLinkActionEvent();
};

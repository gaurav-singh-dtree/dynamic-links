var Actions = {
  linkActionClass: ".actions",
  bindLinkActionEvent: function() {
    document.querySelectorAll(this.linkActionClass).forEach(element => {
      element.addEventListener('click', (event) => {
        event.preventDefault();
        this.handleLinkEvent(element);
      })
    })
  },

  handleLinkEvent: function(element) {
    let { linkKey, linkStatus } = element.dataset;
    var formData = new FormData();
    formData.append('id', linkKey);
    formData.append('status', linkStatus);
    fetch('links/update_status', {
      method: 'PUT',
      body: formData,
    })
    .then(response => response.json())
    .then(data => {
      this.handleSuccessEvent(data, element);
    })
    .catch(error => {
      this.handleErrorEvent(error, element);
    });
  },

  handleSuccessEvent: function(data, element) {
    element.dataset.linkStatus = this.getButtonStatusAfterClick(element);
    element.innerText = this.getButtonTextAfterClick(element);
    console.log(data)
  },

  handleErrorEvent: function(error, element) {
    console.log(error);
  },

  getButtonTextAfterClick: function(element) {
    var text = (element.innerText === 'Activate' ? 'Disable' : 'Activate');
    return text;
  },

  getButtonStatusAfterClick: function(element) {
    var status = (element.dataset.linkStatus === 'true' ? false : true);
    return status;
  }
}

window.onload = (event) => {
  Actions.bindLinkActionEvent();
};
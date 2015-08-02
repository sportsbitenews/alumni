axios.railsPost = function(url, data) {
  return axios({
    method: 'post',
    url: url,
    data: data,
    headers: {
      'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').attributes["content"].value
    }
  });
}

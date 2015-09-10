class SearchBar extends React.Component {
  render() {
    return (
      <div>
        <input ref="keywords" type="text" onKeyUp={this.onKeyUp.bind(this)} placeholder="ruby" />
      </div>
    );
  }

  onKeyUp(e) {
    var keywords = React.findDOMNode(this.refs.keywords).value;
    if (keywords.length == 0 || keywords.length > 2) {
      PostActions.search(keywords);
    }
  }
}

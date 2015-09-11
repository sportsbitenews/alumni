class SearchBar extends React.Component {
  render() {
    return (
      <div className='search-bar' ref='espaceFocus'>
        <i className='mdi mdi-magnify'/>
        <input ref="keywords" onKeyDown={this.handleKeydown.bind(this)} type="text" onKeyUp={this.onKeyUp.bind(this)} placeholder="ruby" />
      </div>
    );
  }

  onKeyUp(e) {
    var keywords = React.findDOMNode(this.refs.keywords).value;
    if (keywords.length == 0 || keywords.length > 2) {
      PostActions.search(keywords);
    }
  }

  handleKeydown(e) {
    if (e.which == 27 && this.props.active) {
      console.log('LOL')
      PubSub.publish('searchBarActiveState', false)
    }
  }

  componentDidMount() {
    PubSub.subscribe('searchBarActiveState', (msg, data) => {
      data ? React.findDOMNode(this.refs.keywords).focus() : React.findDOMNode(this.refs.espaceFocus).focus()
    })
  }
}

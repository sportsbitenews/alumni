class SearchIcon extends React.Component {
  constructor(props) {
    super(props)
    this.state = { active: false }
  }

  render() {
    var iconClasses = classNames({
      'search-icon': true,
      'is-active': this.state.active
    })
    return(
      <div className={iconClasses} onClick={this.handleClick.bind(this)}>
        <i className='mdi mdi-magnify'/>
        <i className='mdi mdi-chevron-up'/>
      </div>
    )
  }

  handleClick() {
    PubSub.publish('searchBarActiveState', !this.state.active)
    PubSub.subscribe('searchBarActiveState', (msg, data) => {
      this.setState({ active: data })
    })
  }
}

class Headers extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      searchBarActive: false
    }
  }

  render() {
    var searchBarClasses = classNames({
      'search-bar-overlay': true,
      'is-active': this.state.searchBarActive
    })
    return(
      <header className='headers'>
        <div className={searchBarClasses}>
          <SearchBar active={this.state.searchBarActive}/>
        </div>
        <div>
          <div className="col-xs-3">
            <header className='posts-column-header resources-column-header'>
              <div>
                #resources
              </div>
            </header>
          </div>
          <div className='col-xs-3'>
            <header className='posts-column-header questions-column-header '>
              <div>
                #help
              </div>
            </header>
          </div>
          <div className='col-xs-3'>
            <header className='posts-column-header jobs-column-header '>
              <div>
                #jobs
              </div>
            </header>
          </div>
          <div className='col-xs-3'>
            <header className='posts-column-header milestones-column-header'>
              <div>
                #milestones
              </div>
            </header>
          </div>
        <div className='clear' />
        </div>
      </header>
    )
  }

  componentDidMount() {
    PubSub.subscribe('searchBarActiveState', (msg, data) => {
      this.setState({searchBarActive: data})
    })
  }
}

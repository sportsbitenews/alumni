class Headers extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return(
      <header className='headers'>
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
      </header>
    )
  }
}

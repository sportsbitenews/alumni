class PostSubmissions extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <form>
        <div className='post-submissions-header resource-details'>
          <div className='container'>
            Post a resource
          </div>
        </div>
        <div className='post-submissions-tabs-overlay'>
          <div className='post-submissions-tabs'>
            <div className='post-submissions-tab'>
              Ressource
            </div>
          </div>
        </div>
        <div className='container'>
          <div className='post-submissions-row'>
            <label htmlFor='title'>
              <i className='mdi mdi-crown'></i>Title
            </label>
            <input placeholder="The title of the resource" name='title' />
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='url'>
              <i className='mdi mdi-link-variant'></i>Link
            </label>
            <input placeholder='http://www...' name='url' />
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='tagline'>
              <i className='mdi mdi-rocket'></i>Catchline
            </label>
            <input placeholder='Describe the resource' name='catchline' />
          </div>
        </div>
        <div className='post-submissions-submit'>
          <a class='button'>Post it</a>
        </div>
      </form>
    )
  }
}

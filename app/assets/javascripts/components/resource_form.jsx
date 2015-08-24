class ResourceForm extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    if (this.props.errors){
      if (this.props.errors.title != undefined) {var errorTitle = this.props.errors.title}
      if (this.props.errors.tagline != undefined) {var errorTagline = this.props.errors.tagline}
      if (this.props.errors.url != undefined) {var errorUrl = this.props.errors.url}
    }

    return (
      <form action={Routes.resources_path()} method='post'>
        <div className='container'>
          <div className='post-submissions-row'>
            <label htmlFor='resource[url]'>
              <i className='mdi mdi-link-variant'></i>Link
            </label>
            <input ref='url' defaultValue={this.props.resource.url} placeholder='http://www...' name='resource[url]' />
            <div className='errors'>
              {errorUrl}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='resource[title]'>
              <i className='mdi mdi-format-text'></i>Title
            </label>
            <input ref='title' defaultValue={this.props.resource.title} placeholder="The title of the resource" name='resource[title]' />
            <div className='errors'>
              {errorTitle}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='resource[tagline]'>
              <i className='mdi mdi-rocket'></i>Catchline
            </label>
            <input ref='tagline' defaultValue={this.props.resource.tagline} placeholder='Describe the resource' name='resource[tagline]' />
            <div className='errors'>
              {errorTagline}
            </div>
          </div>
        </div>
        <div className='post-submissions-submit'>
          <input type='submit' className='button button-resource' value='Post it' onClick={this.submitForm.bind(this)} />
        </div>
        <div dangerouslySetInnerHTML={{__html: Csrf.getInput()}}></div>
      </form>
    );
  }

  submitForm() {
    var title = React.findDOMNode(this.refs.title).value
    var url = React.findDOMNode(this.refs.url).value
    var tagline = React.findDOMNode(this.refs.tagline).value
    ResourceActions.submit(title, url, tagline)
  }

  onUrlChange(e) {
    var url = e.target.value;
    if (url.match(/https?:\/\/[\w-]+(\.[\w-]*)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?/i)) {
      $.ajax({
        type: "post",
        url: Routes.preview_resources_path(),
        data: { url: url },
        success: (data) => {
          if (data.url) {
            this.setState({
              title: data.title,
              content: data.description
            })
          }
        }
      })
    }
  }
};

var CityForm = React.createClass({
  getInitialState: function() {
    return {
      preview: false,
      renderedContent: this.props.renderedContent,
      content: this.props.specifics
    }
  },
  componentDidMount() {
    AnswerStore.listen(this.onStoreChange);
    PubSub.subscribe('focusRealInput', () => {
      this.contentDOMNode().focus()
      this.contentDOMNode().value = ''
    })
  },
  componentWillUnmount() {
    AnswerStore.unlisten(this.onStoreChange);
  },
  render: function() {
    var specificsTextareaClasses = classNames({
      'hidden': this.state.preview,
      'form-group': true,
      'city_specifics': true,
      'text optional': true
    })
    var specificsPreviewClasses = classNames({
      'hidden': this.state.preview == false,
      'city-form-preview': true
    })
    var specificsPreviewButtonClasses = classNames({
      'hidden': this.state.preview,
      'btn': true,
      'btn-default': true,
      'button-discret': true,
      'form-control': true
    })
    var specificsWriteButtonClasses = classNames({
      'hidden': this.state.preview == false,
      'btn': true,
      'btn-default': true,
      'button-discret': true,
      'form-control': true
    })
    return (
      <div className="container padded">
        <form action={Routes.city_path(this.props.city)} className="simple_form edit_city" id="edit_city" method="post">
          <input type="hidden" name="_method" value="patch" />
          <input type='hidden' name='authenticity_token' value={this.props.token} />
          <div className={specificsTextareaClasses}>
            <textarea ref='specifics' name="city[specifics]" id="city_specifics" rows="20" className="text optional form-control" placeholder={this.props.placeholder} defaultValue={this.props.specifics} ></textarea>
          </div>
          <div className={specificsPreviewClasses} dangerouslySetInnerHTML={{__html: this.state.renderedContent}}></div>
          <div className="text-right padded-1em form-group form-inline">
            <button className={specificsPreviewButtonClasses} onClick={this.onPreviewClick}>Preview</button>
            <button className={specificsWriteButtonClasses} onClick={this.onWriteClick}>Write</button>
            <input type="submit" className="btn btn-default button-discret form-control" value="Update" />
          </div>
        </form>
      </div>
    );
  },
  onPreviewClick(e) {
    e.preventDefault();
    this.setState({ preview: true });
    AnswerActions.preview(React.findDOMNode(this.refs.specifics).value);
  },
  onWriteClick(e) {
    e.preventDefault();
    this.setState({ preview: false });
  },
  onStoreChange(store) {
    var newAnswer = store.getNewAnswer();
    console.log(newAnswer.content);
    if (newAnswer.content == "") {
      this.setState({
        renderedContent: 'Nothing to preview.'
      });
    } else if (newAnswer) {
      this.setState({
        renderedContent: newAnswer.rendered_content
      });
    }
  }
});

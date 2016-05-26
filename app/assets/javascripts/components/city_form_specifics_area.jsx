var CityFormSpecificsArea = React.createClass({
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
      'btn-xs': true,
      'pull-right': true
    })
    var specificsWriteButtonClasses = classNames({
      'hidden': this.state.preview == false,
      'btn': true,
      'btn-default': true,
      'button-discret': true,
      'btn-xs': true,
      'pull-right': true
    })
    return (
      <div className='form-group'>
        <div className="padded-1em form-group form-inline">
          <label className='city_label'>{this.props.area_label}:</label>
          <button className={specificsPreviewButtonClasses} onClick={this.onPreviewClick}>Preview</button>
          <button className={specificsWriteButtonClasses} onClick={this.onWriteClick}>Write</button>
        </div>
        <div className={specificsTextareaClasses}>
          <textarea ref={this.props.area_ref} name={this.props.area_name} id={this.props.area_id} rows="20" className="text optional form-control" placeholder={this.props.placeholder} defaultValue={this.props.specifics} ></textarea>
        </div>
        <div className={specificsPreviewClasses} dangerouslySetInnerHTML={{__html: this.state.renderedContent}}></div>
      </div>
    );
  },
  onPreviewClick(e) {
    e.preventDefault();
    this.setState({ preview: true });
    console.log(this.refs[this.props.area_ref]);
    AnswerActions.preview(React.findDOMNode(this.refs[this.props.area_ref]).value);
  },
  onWriteClick(e) {
    e.preventDefault();
    this.setState({ preview: false });
  },
  onStoreChange(store) {
    var newAnswer = store.getNewAnswer();
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

var ResourceForm = React.createClass({
  getInitialState: function() {
    return {
      title: this.props.resource.title,
      content: this.props.resource.content
    };
  },

  render: function() {
    var titleComponent, contentComponent, buttonComponent, errorsComponent;

    if (_.size(this.props.errors) > 0) {
      errorsComponent = <div>{JSON.stringify(this.props.errors)}</div>;
    }

    if (this.props.resource.url || this.state.title) {
      titleComponent = <input name="resource[title]" defaultValue={this.state.title} />;
    }

    if (this.props.resource.url || this.state.content) {
      contentComponent = <textarea name="resource[content]" defaultValue={this.state.content} />;
    }

    if (this.props.resource.url || titleComponent || contentComponent) {
      buttonComponent = <input type="submit" value="GO" />
    }

    return (
      <form action={Routes.resources_path()} method="post">
        <input type="hidden" value={this.props.authenticity_token} name="authenticity_token" />
        {errorsComponent}
        <input name="resource[url]" ref="url" defaultValue={this.props.resource.url}
               onChange={this.onUrlChange} placeholder="Copy paste the resource url" />
        {titleComponent}
        {contentComponent}
        {buttonComponent}
      </form>
      );
  },

  onUrlChange: function(e) {
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
});

var CommentBox = React.createClass({displayName: "CommentBox",
  getInitialState: function() {
    return {data: []};
  },
  loadCommentsFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        if(data.is_success == 0) {
          return
        }
        this.setState({data: data.results.data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  handleCommentSubmit: function(comment) {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: comment,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  componentDidMount: function() {
    this.loadCommentsFromServer();
    setInterval(this.loadCommentsFromServer, this.props.pollInterval);
  },
  render: function() {
    return (
      React.createElement("div", {className: "commentBox"}, 
        React.createElement(CommentList, {data: this.state.data}), 
        React.createElement(CommentForm, {onCommentSubmit: this.handleCommentSubmit})
      )
    );
  }
});

var CommentList = React.createClass({displayName: "CommentList",
  render: function() {
    var commentNodes = this.props.data.map(function (comment) {
      return (
        React.createElement(Comment, {key: comment.id, comment: comment})
      );
    });
    return (
      React.createElement("div", {className: "ui comments"}, 
        React.createElement("h3", {className: "ui dividing header"}, "Comments"), 
        commentNodes
      )
    );
  }
});

var CommentForm = React.createClass({displayName: "CommentForm",
  handleSubmit: function(e) {
    e.preventDefault();
    var comment = React.findDOMNode(this.refs.comment).value.trim();
    if (!comment) {
      return;
    }
    this.props.onCommentSubmit({comment: comment});
    React.findDOMNode(this.refs.comment).value = '';
    return;
  },
  render: function() {
    return (
      React.createElement("form", {className: "ui reply form", onSubmit: this.handleSubmit}, 
        React.createElement("div", {className: "field"}, 
          React.createElement("textarea", {ref: "comment"})
        ), 
        React.createElement("input", {type: "submit", className: "ui blue submit icon button", value: "post"})
      )
    );
  }
});

var Comment = React.createClass({displayName: "Comment",
  render: function() {
    return (
      React.createElement("div", {className: "comment"}, 
        React.createElement("a", {className: "avatar"}, 
          React.createElement("img", {src: this.props.comment.image})
        ), 
        React.createElement("div", {className: "content"}, 
          React.createElement("a", {className: "author"}, this.props.comment.name), 
          React.createElement("div", {className: "metadata"}, 
            React.createElement("span", {className: "date"}, this.props.comment.time_ago)
          ), 
          React.createElement("div", {className: "text"}, 
            this.props.comment.comment
          )
        )
      )
    );
  }
});

var comments_url = ("/kiita_api/comments/" + article_id)
React.render(
  React.createElement(CommentBox, {url: comments_url, pollInterval: 2000}),
  document.getElementById('comment_area')
);

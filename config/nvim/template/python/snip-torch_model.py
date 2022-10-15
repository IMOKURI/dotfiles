class {{_input_:model_name}}(nn.Module):
    def __init__(self, c, tf_initialization=False):
        super().__init__()
        self.amp = c.settings.amp
        self.model_input = c.model_params.model_input
        self.model_output = c.settings.n_class

        ...
        {{_cursor_}}

        if tf_initialization:
            self._tf_reinitialize()

    def _tf_reinitialize(self):
        """
        Tensorflow/Keras-like initialization
        """
        for name, p in self.named_parameters():
            if "fc" in name:
                if "weight" in name:
                    nn.init.xavier_uniform_(p.data)
                elif "bias" in name:
                    p.data.fill_(0)

    def forward(self, x):
        with amp.autocast(enabled=self.amp):
            ...

        return x

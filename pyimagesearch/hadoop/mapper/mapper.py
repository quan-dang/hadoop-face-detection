from imutils import encodings
import json
import sys

class Mapper(object):
    @staticmethod
    def parse_input(stream):
        # loop over the lines and yield each line
        for line in stream:
            yield line.rstrip()

    @staticmethod
    def handle_input(line, sep="\t"):
        # split the line into the imageID, path, and image, then decode the image
        (imageID, path, image) = line.strip().split(sep)
        image = encodings.base64_decode_image(image)

        # return a tuple of the imageID, filename and decoded image
        return (imageID, path, image)

    @staticmethod
    def output_row(imageID, path, data, stream=sys.stdout, sep="\t"):
        # write the imageID, path, and data to the output stream
        stream.write("{image_id}{sep}{path}{sep}{data}\n".format(
            image_id=imageID, path=path, data=json.dumps(data), sep=sep
        ))
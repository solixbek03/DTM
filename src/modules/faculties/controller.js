const { GET } = require("./model");

const getFaculties = async (req, res, next) => {
    try {
        const response = await GET(req.params)

        if (response.error) return next(response)

        res.status(200).send({
            status: 200,
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getFaculties
}